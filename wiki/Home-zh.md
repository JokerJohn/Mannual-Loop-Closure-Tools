# Manual Loop Closure Tools Wiki

[English](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Home) | [中文](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Home-zh)

本 Wiki 是独立手动闭环工作流的实用使用手册，重点介绍工具操作、图编辑逻辑、优化后端行为和常见问题。

**作者**：[Xiangcheng HU](https://github.com/JokerJohn)、[Jin Wu](https://github.com/zarathustr)、[Xieyuanli Chen](https://github.com/Chen-Xieyuanli)  
**联系邮箱**：[xhubd@connect.ust.hk](mailto:xhubd@connect.ust.hk)

<p align="center">
  <img src="https://raw.githubusercontent.com/JokerJohn/Mannual-Loop-Closure-Tools/main/assets/screenshots/edge-selected.png" alt="Manual Loop Closure Tools screenshot" width="82%" />
</p>

## 从这里开始

- [快速开始](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Quick-Start-zh)
- [GUI 工作流](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/GUI-Workflow-zh)
- [图编辑逻辑](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Graph-Editing-zh)
- [优化后端](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Optimization-Backends-zh)
- [常见问题排查](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Troubleshooting-zh)
- [FAQ](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/FAQ-zh)

## 工具定位

本项目是一个面向激光雷达建图结果的离线闭环编辑工具，输入通常已经包含：

- `pose_graph.g2o`
- `optimized_poses_tum.txt`
- `key_point_frame/*.pcd`

它可以帮助你：

- 对比 `Original` 和 `Working` 两套轨迹
- 选中节点对或已有闭环边
- 在地图坐标系下预览 source / target 点云
- 运行 GICP 并验证闭环候选
- 新增、替换、禁用、恢复并导出图改动

## 核心编辑动作

### 新增手工闭环边

<p align="center">
  <img src="https://raw.githubusercontent.com/JokerJohn/Mannual-Loop-Closure-Tools/main/assets/add_loopsx3.gif" alt="Add loop demo" width="82%" />
</p>

### 替换已有闭环边

<p align="center">
  <img src="https://raw.githubusercontent.com/JokerJohn/Mannual-Loop-Closure-Tools/main/assets/replace_loopx3.gif" alt="Replace loop demo" width="82%" />
</p>

### 禁用已有闭环边

<p align="center">
  <img src="https://raw.githubusercontent.com/JokerJohn/Mannual-Loop-Closure-Tools/main/assets/disable_loop.gif" alt="Disable loop demo" width="82%" />
</p>

## 建议阅读顺序

1. [快速开始](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Quick-Start-zh)
2. [GUI 工作流](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/GUI-Workflow-zh)
3. [图编辑逻辑](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Graph-Editing-zh)
4. [优化后端](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Optimization-Backends-zh)
5. [常见问题排查](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/Troubleshooting-zh)

## 仓库链接

- [English README](https://github.com/JokerJohn/Mannual-Loop-Closure-Tools/blob/main/README.md)
- [中文 README](https://github.com/JokerJohn/Mannual-Loop-Closure-Tools/blob/main/README.zh.md)
- [安装说明](https://github.com/JokerJohn/Mannual-Loop-Closure-Tools/blob/main/docs/INSTALL.md)
- [Python GTSAM 4.3 安装](https://github.com/JokerJohn/Mannual-Loop-Closure-Tools/blob/main/docs/INSTALL_GTSAM_PYTHON.md)
- [工具说明](https://github.com/JokerJohn/Mannual-Loop-Closure-Tools/blob/main/docs/TOOL_README.md)
- [版本记录](https://github.com/JokerJohn/Mannual-Loop-Closure-Tools/blob/main/CHANGELOG.md)
