@echo off
REM ══════════════════════════════════════════
REM  Windows 启动文件夹快捷方式安装器
REM  把 start.bat 加入开机自启动
REM ══════════════════════════════════════════

set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SCRIPT_DIR=%~dp0"
set "SHORTCUT=%STARTUP%\随手.bat"

REM 复制 start.bat 到启动文件夹
copy /Y "%SCRIPT_DIR%start.bat" "%SHORTCUT%" >nul 2>&1

if %errorlevel% equ 0 (
    echo [OK] Installed! 随手 will auto-start on login.
    echo      File: %SHORTCUT%
) else (
    echo [FAIL] Could not copy to Startup folder.
    echo        Try running as Administrator, or manually copy:
    echo        %SCRIPT_DIR%start.bat
    echo        to: %STARTUP%
)
pause
