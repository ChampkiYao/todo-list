# Todo List

A minimalist single-file HTML todo app with frosted glass UI. No build tools, no dependencies — just open the file.

## Features

- **Add & organize** tasks in order, drag-drop or arrow buttons to reorder
- **Pin to top/bottom** for quick access to important items
- **Double-click to edit** task text inline
- **Daily auto-reset** — checkmarks clear at midnight, preset habits reappear
- **Collapse completed** — hide finished tasks with one click
- **Undo delete** — 3-second toast to recover accidentally deleted tasks
- **Auto-backup** — JSON backup downloads automatically on every data change (throttled to 3s)
- **Export/Import** — manual backup & restore via JSON files
- **Persistent storage** — all data saved to `localStorage`, survives refresh
- **Mobile-friendly** — responsive design with touch drag support

## Usage

Open `todo.html` in any modern browser. That's it.

## Tech

- Single HTML file (~700 lines)
- Pure HTML / CSS / JS — zero external dependencies
- Frosted glass UI with CSS `backdrop-filter`
- `localStorage` for persistence
- Auto-backup to JSON on every change

## Backup & Restore

- **Auto-backup**: A JSON file downloads automatically whenever tasks change (throttled to every 3 seconds max)
- **Export**: Click "Export" to download a full backup manually
- **Import**: Click "Import" and select a previously exported JSON file to restore all tasks, order, and settings

Backup files are named `todo-backup-YYYY-MM-DDTHH-MM-SS.json` and contain all tasks, sort order, date state, and collapse preference.

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
