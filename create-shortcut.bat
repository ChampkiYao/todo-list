@echo off
set "SCRIPT_DIR=%~dp0"
set "DESKTOP=%USERPROFILE%\Desktop"

powershell -Command "$s = (New-Object -COM WScript.Shell).CreateShortcut('%DESKTOP%\Suishou.lnk'); $s.TargetPath = '%SCRIPT_DIR%start.vbs'; $s.WorkingDirectory = '%SCRIPT_DIR%'; $s.Description = 'Start Suishou'; $s.IconLocation = '%SCRIPT_DIR%favicon.ico,0'; $s.Save()"

echo.
echo   Shortcut created on Desktop: "Suishou"
echo.
pause
