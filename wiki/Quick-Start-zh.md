# 快速开始

[English](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Quick-Start) | [中文](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Quick-Start-zh)

## 推荐路径

```bash
cd ~/my_git/Mannual-Loop-Closure-Tools
make venv
source .venv/bin/activate
python launch_gui.py --session-root /path/to/mapping_session
```

默认情况下，工具优先使用 Python backend。

## 最小输入

你的 session 通常需要已经包含：

- `pose_graph.g2o`
- `optimized_poses_tum.txt`
- `key_point_frame/*.pcd`

## 典型流程

1. 加载 session。
2. 检查轨迹。
3. 选择节点对或已有闭环边。
4. 预览 source 和 target 点云。
5. 运行 GICP。
6. 新增 / 替换 / 禁用图改动。
7. 优化 working graph。
8. 导出最终结果。

## 快速链接

- [GUI 工作流](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/GUI-Workflow-zh)
- [图编辑逻辑](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Graph-Editing-zh)
- [常见问题排查](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Troubleshooting-zh)
