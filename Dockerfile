FROM python:3.10-bullseye AS builder

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    VIRTUAL_ENV=/opt/mlct-venv \
    PATH=/opt/mlct-venv/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    pkg-config \
    libboost-all-dev \
    libtbb-dev \
    libgl1 \
    libglib2.0-0 \
    libxext6 \
    libxrender1 \
    libsm6 \
    libegl1 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    libdbus-1-3 \
    libnss3 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv "$VIRTUAL_ENV"

WORKDIR /workspace/manual-loop-closure

COPY requirements.txt .
COPY scripts/install_gtsam_python.sh scripts/install_gtsam_python.sh

RUN pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt

RUN bash scripts/install_gtsam_python.sh

COPY . .

RUN python -m py_compile launch_gui.py gui/manual_loop_closure_tool.py gui/manual_loop_closure/*.py gui/manual_loop_closure/python_optimizer/*.py gui/merge_pcds.py scripts/*.py

FROM python:3.10-bullseye AS runtime

ENV DEBIAN_FRONTEND=noninteractive \
    VIRTUAL_ENV=/opt/mlct-venv \
    PATH=/opt/mlct-venv/bin:$PATH \
    QT_X11_NO_MITSHM=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    libxext6 \
    libxrender1 \
    libsm6 \
    libegl1 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    libdbus-1-3 \
    libnss3 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/mlct-venv /opt/mlct-venv
COPY --from=builder /workspace/manual-loop-closure /workspace/manual-loop-closure

WORKDIR /workspace/manual-loop-closure

CMD ["python", "launch_gui.py", "--help"]
