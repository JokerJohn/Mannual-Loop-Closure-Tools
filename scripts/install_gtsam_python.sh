#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python}"
GTSAM_REF="${GTSAM_REF:-4.3a0}"
GTSAM_SOURCE_ROOT="${GTSAM_SOURCE_ROOT:-$REPO_ROOT/.cache/gtsam}"
GTSAM_SRC_DIR="$GTSAM_SOURCE_ROOT/src"
GTSAM_BUILD_DIR="${GTSAM_BUILD_DIR:-$GTSAM_SOURCE_ROOT/build-$GTSAM_REF}"

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  echo "[manual-loop-closure] Python executable not found: $PYTHON_BIN" >&2
  exit 1
fi

INSTALL_PREFIX="${GTSAM_INSTALL_PREFIX:-${VIRTUAL_ENV:-}}"
if [ -z "$INSTALL_PREFIX" ]; then
  echo "[manual-loop-closure] Activate a virtual environment first, or set GTSAM_INSTALL_PREFIX." >&2
  exit 1
fi

echo "[manual-loop-closure] Repo root: $REPO_ROOT"
echo "[manual-loop-closure] Python: $(command -v "$PYTHON_BIN")"
echo "[manual-loop-closure] Install prefix: $INSTALL_PREFIX"
echo "[manual-loop-closure] GTSAM ref: $GTSAM_REF"

"$PYTHON_BIN" -m pip install -r "$REPO_ROOT/requirements.txt"

mkdir -p "$GTSAM_SOURCE_ROOT"
if [ ! -d "$GTSAM_SRC_DIR/.git" ]; then
  git clone https://github.com/borglab/gtsam.git "$GTSAM_SRC_DIR"
fi

git -C "$GTSAM_SRC_DIR" fetch --tags origin
git -C "$GTSAM_SRC_DIR" checkout "$GTSAM_REF"
git -C "$GTSAM_SRC_DIR" submodule update --init --recursive

cmake -S "$GTSAM_SRC_DIR" -B "$GTSAM_BUILD_DIR" \
  -DGTSAM_BUILD_PYTHON=ON \
  -DGTSAM_USE_SYSTEM_EIGEN=OFF \
  -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF \
  -DGTSAM_BUILD_TESTS=OFF \
  -DPYTHON_EXECUTABLE="$(command -v "$PYTHON_BIN")" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX"

cmake --build "$GTSAM_BUILD_DIR" -j"$(nproc)"
cmake --build "$GTSAM_BUILD_DIR" --target python-install

"$PYTHON_BIN" - <<'PY'
import gtsam
print("[manual-loop-closure] gtsam module:", gtsam.__file__)
print("[manual-loop-closure] has LM:", hasattr(gtsam, "LevenbergMarquardtOptimizer"))
print("[manual-loop-closure] has BetweenFactorPose3:", hasattr(gtsam, "BetweenFactorPose3"))
print("[manual-loop-closure] has PriorFactorPose3:", hasattr(gtsam, "PriorFactorPose3"))
print("[manual-loop-closure] has GPSFactor:", hasattr(gtsam, "GPSFactor"))
print("[manual-loop-closure] has writeG2o:", hasattr(gtsam, "writeG2o"))
PY

echo "[manual-loop-closure] GTSAM Python wrapper installation complete."
