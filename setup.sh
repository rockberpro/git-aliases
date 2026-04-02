#!/bin/bash

set -e

GITCONFIG_URL="https://raw.githubusercontent.com/rockberpro/git-aliases/main/git-aliases.gitconfig"
INSTALL_PATH="$HOME/.git-aliases.gitconfig"

HELP_URL="https://raw.githubusercontent.com/rockberpro/git-aliases/main/git-aliases-help.sh"
HELP_PATH="$HOME/.git-aliases-help.sh"

curl -sL "$GITCONFIG_URL" -o "$INSTALL_PATH"

if ! git config --global --get-all include.path | grep -qF "$INSTALL_PATH"; then
    git config --global --add include.path "$INSTALL_PATH"
fi

curl -sL "$HELP_URL" -o "$HELP_PATH"
chmod +x "$HELP_PATH"

echo "git-aliases installed: $INSTALL_PATH"
echo "git-aliases help installed: $HELP_PATH"
