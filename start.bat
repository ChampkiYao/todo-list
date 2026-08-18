@echo off
title Suishou
echo.
echo   Starting Suishou...
echo.

start /b node "%~dp0server.js"
timeout /t 1 /nobreak >nul
start http://localhost:3000

echo   Browser opened. Close this window or press Ctrl+C to stop.
echo.
pause
