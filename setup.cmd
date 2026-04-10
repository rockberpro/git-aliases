@echo off
setlocal

set "GITCONFIG_URL=https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga.gitconfig"
set "INSTALL_PATH=%USERPROFILE%\.git-lga.gitconfig"

set "HELP_URL=https://raw.githubusercontent.com/rockberpro/git-lga/main/git-lga-help.sh"
set "HELP_PATH=%USERPROFILE%\.git-lga-help.sh"

curl -sL "%GITCONFIG_URL%" -o "%INSTALL_PATH%"
if errorlevel 1 (
    echo Error: failed to download git-lga.gitconfig
    exit /b 1
)

git config --global --get-all include.path | findstr /C:"%INSTALL_PATH%" >nul 2>&1
if errorlevel 1 (
    git config --global --add include.path "%INSTALL_PATH%"
)

curl -sL "%HELP_URL%" -o "%HELP_PATH%"
if errorlevel 1 (
    echo Error: failed to download git-lga-help.sh
    exit /b 1
)

echo git-lga installed: %INSTALL_PATH%
echo git-lga help installed: %HELP_PATH%
