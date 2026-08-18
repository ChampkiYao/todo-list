@echo off
title 随手
echo.
echo   Starting 随手...
echo.

:: Start server in background
start /b node "%~dp0server.js"

:: Wait a moment for server to start, then open browser
timeout /t 1 /nobreak >nul
start http://localhost:3000

echo   Browser opened. Close this window or press Ctrl+C to stop.
echo.
pause
