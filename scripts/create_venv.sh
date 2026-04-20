#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python3}"
VENV_DIR="${VENV_DIR:-$REPO_ROOT/.venv}"

echo "[manual-loop-closure] Repo root: $REPO_ROOT"
echo "[manual-loop-closure] Python: $PYTHON_BIN"
echo "[manual-loop-closure] Venv: $VENV_DIR"

"$PYTHON_BIN" -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

python -m pip install --upgrade pip wheel setuptools
python -m pip install -r "$REPO_ROOT/requirements.txt"

echo
echo "[manual-loop-closure] Virtual environment is ready."
echo "[manual-loop-closure] Activate it with:"
echo "  source \"$VENV_DIR/bin/activate\""
echo "[manual-loop-closure] Install the GTSAM 4.3 Python wrapper with:"
echo "  make gtsam-python"
echo "[manual-loop-closure] Then launch:"
echo "  python \"$REPO_ROOT/launch_gui.py\" --session-root /path/to/session"
