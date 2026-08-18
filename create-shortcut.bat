@echo off
:: Creates a desktop shortcut for Todo List
set "SCRIPT_DIR=%~dp0"
set "DESKTOP=%USERPROFILE%\Desktop"

:: Create shortcut via PowerShell
powershell -Command "$s = (New-Object -COM WScript.Shell).CreateShortcut('%DESKTOP%\Todo List.lnk'); $s.TargetPath = '%SCRIPT_DIR%start.bat'; $s.WorkingDirectory = '%SCRIPT_DIR%'; $s.Description = 'Start Todo List'; $s.Save()"

echo.
echo   Shortcut created on Desktop: "Todo List"
echo.
pause
