# Optimization Backends

[English](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Optimization-Backends) | [中文](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Optimization-Backends-zh)

## Python First

The standalone project uses the Python optimizer as the default backend.

Why:

- simpler installation
- no mandatory ROS / catkin requirement
- consistent integration with the PyQt + Open3D GUI
- validated parity against the legacy C++ backend

## Optimize Modes

The Python backend now exposes two solve modes:

- `Fast ISAM2`
  - default in the GUI
  - intended for repeated working-graph updates during manual editing
- `Accurate LM`
  - batch-style reference solve
  - useful for parity checks or final confirmation before export

In the current GUI:

- `Fast ISAM2` lives in `Advanced -> Optimize`
- `MapVoxel` also lives in `Advanced` and defaults to `0.1 m`
- `TgtVoxel` lives in `Registration` and defaults to `0.1 m`

## Legacy C++ Fallback

The C++ backend is still supported as an optional fallback.

Use it when:

- you already have the legacy backend environment
- you want direct parity checks against historical runs
- you need a fallback when Python GTSAM is temporarily unavailable

## Parameter Consistency

The Python backend follows the same runtime-parameter precedence used by the legacy optimizer:

1. explicit CLI / GUI options
2. `runtime_params.yaml`
3. validated offline defaults

The legacy C++ fallback still solves with LM. If it receives `--optimize-mode isam2`, it reports the mode mismatch and falls back to LM explicitly.

## Output Files

Both backends export:

- `pose_graph.g2o`
- `optimized_poses_tum.txt`
- `pose_graph.png`
- `manual_loop_report.json`

The full output layout is:

- `manual_loop_projects/<project_id>/`
  - edit-state and resume files
- `manual_loop_runs/<run_id>/`
  - actual optimizer outputs
- `manual_loop_exports/<export_id>/`
  - final-export manifest pointing to one selected run

`global_map_manual_imu.pcd` and `trajectory.pcd` are built during `Export` by default so iterative graph editing stays responsive.
