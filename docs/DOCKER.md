# Docker Guide

## Why Docker

The default user path is already Python-first, but Docker removes most host-side dependency friction, especially around:

- Python 3.10
- Open3D / PyQt runtime libraries
- GTSAM 4.3 Python wrapper build

It is the simplest reproducible path when you want to avoid local environment drift.

## Build the Image

```bash
cd ~/my_git/Mannual-Loop-Closure-Tools
docker build -t manual-loop-closure-tools:latest .
```

## Run the GUI with X11

```bash
xhost +local:docker
docker run --rm -it \
  --net=host \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /path/to/mapping_session:/data/session \
  manual-loop-closure-tools:latest \
  python launch_gui.py --session-root /data/session
```

## Run the Python Optimizer CLI

```bash
docker run --rm -it \
  -v /path/to/session:/data/session \
  manual-loop-closure-tools:latest \
  python gui/manual_loop_closure/python_optimizer/cli.py \
    --session-root /data/session \
    --g2o /data/session/pose_graph.g2o \
    --tum /data/session/optimized_poses_tum.txt \
    --keyframe-dir /data/session/key_point_frame \
    --constraints-csv /data/session/manual_loop_constraints.csv \
    --output-dir /data/session/manual_loop_runs/docker_test \
    --map-voxel-leaf 0.0
```

## Notes

- The Docker image already builds the GTSAM 4.3 Python wrapper during image creation.
- The legacy C++ backend is not required for the normal Docker workflow.
- If you need the legacy backend for developer parity checks, keep using a local build outside the default Docker path.

## Docker FAQ

### Do I need ROS or the legacy C++ backend inside Docker?

No. The default Docker path is Python-only and already includes the GTSAM 4.3 Python wrapper.

### Why do I need `xhost +local:docker` before launching the GUI?

The GUI uses PyQt and Open3D, so the container needs permission to talk to your host X server.

Recommended flow:

```bash
xhost +local:docker
docker run ...
```

When finished, you can revoke that permission:

```bash
xhost -local:docker
```

### Where should I mount my mapping session?

Mount the session directory to `/data/session` and pass that path to the GUI:

```bash
-v /path/to/mapping_session:/data/session
python launch_gui.py --session-root /data/session
```

### Will exported outputs stay on my host machine?

Yes. Anything written under `/data/session/manual_loop_runs/...` is written into the host directory you mounted.

### Can I run the optimizer without opening the GUI?

Yes. Use the Python optimizer CLI:

```bash
docker run --rm -it \
  -v /path/to/session:/data/session \
  manual-loop-closure-tools:latest \
  python gui/manual_loop_closure/python_optimizer/cli.py \
    --session-root /data/session \
    --g2o /data/session/pose_graph.g2o \
    --tum /data/session/optimized_poses_tum.txt \
    --keyframe-dir /data/session/key_point_frame \
    --constraints-csv /data/session/manual_loop_constraints.csv \
    --output-dir /data/session/manual_loop_runs/docker_test \
    --map-voxel-leaf 0.0
```

### What if I am on a headless server and only want exports?

Skip the GUI and run the CLI command above. The CLI path does not require X11.
