# Todo List

A minimalist single-file HTML todo app with frosted glass UI. Data saves to a local JSON file via a tiny Node.js server.

## Quick Start (Windows)

### Option 1 — Desktop Shortcut (Recommended)

1. Double-click `create-shortcut.bat` (only needed once)
2. A "Todo List" icon appears on your Desktop
3. Double-click the icon anytime to launch

### Option 2 — One-Click Launch

Double-click `start.bat`. The server starts and your browser opens automatically.

### Option 3 — Command Line

```bash
node server.js
```

Then open **http://localhost:3000** in your browser.

---

## Features

- **Add & organize** tasks in order, drag-drop or arrow buttons to reorder
- **Pin to top/bottom** for quick access to important items
- **Double-click to edit** task text inline
- **Daily auto-reset** — checkmarks clear at midnight, preset habits reappear
- **Collapse completed** — hide finished tasks with one click
- **Undo delete** — 3-second toast to recover accidentally deleted tasks
- **File-based storage** — `todo-data.json` sits next to the HTML, readable & editable
- **Mobile-friendly** — responsive design with touch drag support

## How It Works

| Mode | Trigger | Storage |
|---|---|---|
| **Server mode** | `start.bat` or `node server.js` | `todo-data.json` (auto read/write) |
| **Standalone** | Open `todo.html` directly | `localStorage` (browser only, data lost if cache cleared) |

The HTML auto-detects whether the server API is available and switches storage accordingly.

## File Structure

```
├── start.bat            ← Double-click to launch (Windows)
├── create-shortcut.bat  ← Creates desktop shortcut (run once)
├── server.js            ← Node.js server (60 lines, zero deps)
├── todo.html            ← Frontend (single file)
├── todo-data.json       ← Data file (auto-created, auto-read/written)
├── favicon.svg          ← App icon
└── README.md
```

## Requirements

- [Node.js](https://nodejs.org/) v14+ installed and in PATH
- Windows (`.bat` scripts) or any OS (run `node server.js` manually)

## Tech

- Single HTML file, zero external dependencies
- Frosted glass UI with CSS `backdrop-filter`
- `server.js` — Node.js built-in modules only (`http`, `fs`, `path`)
- `todo-data.json` — human-readable JSON, easy to edit or version control

## Preset Tasks

Five daily habits auto-add each new day:

1. Review today's schedule
2. Stay hydrated — drink water
3. Plan top 3 priorities
4. Take a short break every hour
5. Reflect & plan tomorrow before bed

Edit the `PRESET_TASKS` array in the script to customize.

## License

MIT
