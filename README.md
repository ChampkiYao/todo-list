# 随手

一个极简单文件 HTML 待办工具，毛玻璃 UI，数据保存在本地 JSON 文件。

## 快速开始（Windows）

### 方式一 — 桌面快捷方式（推荐）

1. 双击 `create-shortcut.bat`（只需运行一次）
2. 桌面出现"随手"图标
3. 随时双击图标启动

### 方式二 — 一键启动

双击 `start.bat`，服务器启动并自动打开浏览器。

### 方式三 — 命令行

```bash
node server.js
```

然后在浏览器打开 **http://localhost:3000**

---

## 功能

- **添加与排序** — 拖拽或箭头按钮调整顺序
- **置顶/置底** — 重要任务一键置顶
- **双击编辑** — 直接修改任务文字
- **每日重置** — 勾选标记午夜清零
- **折叠已完成** — 一键隐藏已完成任务
- **撤销删除** — 3秒内可恢复误删任务
- **文件存储** — `todo-data.json` 就在旁边，可读可编辑
- **移动端友好** — 响应式设计，支持触屏拖拽

## 工作模式

| 模式 | 触发方式 | 存储位置 |
|---|---|---|
| **服务器模式** | `start.bat` 或 `node server.js` | `todo-data.json`（自动读写） |
| **独立模式** | 直接打开 `todo.html` | `localStorage`（浏览器本地，清缓存会丢失） |

HTML 会自动检测服务器 API 是否可用，并切换存储方式。

## 文件结构

```
├── start.bat            ← 双击启动（Windows）
├── create-shortcut.bat  ← 创建桌面快捷方式（运行一次）
├── install-autostart.bat ← 安装开机自启动（运行一次）
├── server.js            ← Node.js 服务器（零依赖）
├── todo.html            ← 前端（单文件）
├── todo-data.json       ← 数据文件（自动创建、自动读写）
├── favicon.svg          ← 应用图标
└── README.md
```

## 系统要求

- [Node.js](https://nodejs.org/) v14+ 已安装并在 PATH 中
- Windows（`.bat` 脚本）或任意系统（手动运行 `node server.js`）

## 技术

- 单 HTML 文件，零外部依赖
- 毛玻璃 UI（CSS `backdrop-filter`）
- `server.js` — 仅使用 Node.js 内置模块（`http`、`fs`、`path`）
- `todo-data.json` — 人类可读 JSON，方便编辑或版本控制

## License

MIT
