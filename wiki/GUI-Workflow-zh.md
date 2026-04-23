# GUI 工作流

[English](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/GUI-Workflow) | [中文](https://github.com/JokerJohn/Manual-Loop-Closure-Tools/wiki/GUI-Workflow-zh)

## 主界面结构

界面主要分为四块：

- 轨迹面板
- 点云预览面板
- 右侧控制页签（`Summary` / `Advanced`）
- 底部页签（`Graph Changes` / `Execution Log`）

## 轨迹面板

- `Nodes` 用于选择 source / target 节点对。
- `Edges` 用于检查或修订已有闭环边。
- `Working` 与 `Original` 可对比当前编辑图与原始图。
- `Ghost` 会以轻量叠加方式显示另一套轨迹。

## 点云预览

- `Preview`、`Final`、`Compare` 控制点云显示模式。
- `Top`、`Side-Y`、`Side-X` 是相机预设。
- 在编辑模式下，只有 source 可编辑，target 始终固定。

## 右侧控制页

### Summary

- summary 卡片
- delta
- registration
- actions

### Advanced

- 共享协方差参数
- 优化模式选择（默认 `Fast ISAM2`，可选 `Accurate LM`）
- backend 选择
- 导出地图体素参数（`MapVoxel`，默认 `0.1 m`）

### Registration 默认值

- `TgtVoxel` 默认 `0.1 m`
- `MapVoxel` 默认 `0.1 m`
- `MapVoxel` 只影响最终导出，不会拖慢每次 `Optimize`

## 底部页签

- `Graph Changes` 记录已接受的手工改动及禁用/恢复动作。
- `Execution Log` 用于查看优化与 GICP 日志。
