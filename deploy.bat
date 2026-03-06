@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

:: --------------------------------------------------
:: 設定エリア
:: --------------------------------------------------
set "EXPECTED_ORIGIN=git@github.com:2000Re/MosaicFocusTimer.git"
:: デプロイ先のブランチ名をここに指定してください
set "TARGET_BRANCH=branch"
:: --------------------------------------------------

for /f "delims=" %%U in ('git remote get-url origin 2^>nul') do set "ORIGIN=%%U"
if /I not "%ORIGIN%"=="%EXPECTED_ORIGIN%" (
  echo [ERROR] Wrong repository!
  echo Expected: %EXPECTED_ORIGIN%
  echo Current : %ORIGIN%
  pause
  exit /b 1
)

:: ファイルの追加とコミット
git add index.html
git commit -m "Update index.html"

:: 強制プッシュ (-f) を使用して指定ブランチへデプロイ
echo Force deploying to %TARGET_BRANCH%...
git push -f origin HEAD:%TARGET_BRANCH% 

if %ERRORLEVEL% equ 0 (
    echo [SUCCESS] Deployment complete.
) else (
    echo [ERROR] Push failed.
)

pause