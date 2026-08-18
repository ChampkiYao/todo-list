# Todo List

A minimalist single-file HTML todo app with frosted glass UI. Data saves to a local JSON file via a tiny Node.js server.

## Quick Start

```bash
node server.js
```

Open **http://localhost:3000** in your browser. Done.

All tasks, order, and daily state persist in `todo-data.json` next to the HTML file.

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
| **Server mode** | `node server.js` | `todo-data.json` (auto read/write) |
| **Standalone** | Open `todo.html` directly | `localStorage` (browser only) |

The HTML auto-detects whether the server API is available and switches storage accordingly.

## Tech

- Single HTML file, zero external dependencies
- Frosted glass UI with CSS `backdrop-filter`
- `server.js` — 60 lines, Node.js built-in modules only (`http`, `fs`, `path`)
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
