@echo off
REM ══════════════════════════════════════════
REM  Install auto-start on Windows login
REM ══════════════════════════════════════════

set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SCRIPT_DIR=%~dp0"
set "SHORTCUT=%STARTUP%\Suishou.bat"

copy /Y "%SCRIPT_DIR%start.bat" "%SHORTCUT%" >nul 2>&1

if %errorlevel% equ 0 (
    echo [OK] Installed! Suishou will auto-start on login.
    echo      File: %SHORTCUT%
) else (
    echo [FAIL] Could not copy to Startup folder.
    echo        Try running as Administrator, or manually copy:
    echo        %SCRIPT_DIR%start.bat
    echo        to: %STARTUP%
)
pause
