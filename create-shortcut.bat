@echo off
:: Creates a desktop shortcut for 随手
set "SCRIPT_DIR=%~dp0"
set "DESKTOP=%USERPROFILE%\Desktop"

:: Create shortcut via PowerShell with custom icon
powershell -Command "$s = (New-Object -COM WScript.Shell).CreateShortcut('%DESKTOP%\随手.lnk'); $s.TargetPath = '%SCRIPT_DIR%start.bat'; $s.WorkingDirectory = '%SCRIPT_DIR%'; $s.Description = 'Start 随手'; $s.IconLocation = '%SCRIPT_DIR%favicon.ico,0'; $s.Save()"

echo.
echo   Shortcut created on Desktop: "随手"
echo.
pause
