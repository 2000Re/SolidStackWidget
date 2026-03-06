@echo off
setlocal EnableExtensions
chcp 65001 >nul

cd /d C:\MosaicFocusTimer

where netlify >nul 2>&1
if errorlevel 1 (
  echo [ERROR] netlify CLI not found.
  echo        Install: npm install -g netlify-cli
  pause
  exit /b 1
)

echo.
echo [INFO] Starting Netlify Dev (offline, no login/link)...
echo [INFO] URL: http://localhost:8888/
echo [INFO] Stop: Ctrl + C
echo.

start "" "http://localhost:8888/"

call netlify dev -d . -p 8888 --offline --no-open
pause
endlocal
