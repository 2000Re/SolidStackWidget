@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

set "EXPECTED_ORIGIN=git@github.com:2000Re/MosaicFocusTimer.git"
set "TARGET_BRANCH=main"

for /f "delims=" %%U in ('git remote get-url origin 2^>nul') do set "ORIGIN=%%U"
if /I not "%ORIGIN%"=="%EXPECTED_ORIGIN%" (
  echo [ERROR] Wrong repository!
  echo Expected: %EXPECTED_ORIGIN%
  echo Current : %ORIGIN%
  pause
  exit /b 1
)

git add .
git commit -m "Auto deploy"

echo Deploying to %TARGET_BRANCH%...
git push -f origin HEAD:%TARGET_BRANCH%

if %ERRORLEVEL% equ 0 (
    echo [SUCCESS] Deployment complete.
) else (
    echo [ERROR] Push failed.
)

pause