#!/bin/bash

set -e

GITCONFIG_URL="https://raw.githubusercontent.com/rockberpro/git-aliases/main/git-aliases.gitconfig"
INSTALL_PATH="$HOME/.git-aliases.gitconfig"

curl -sL "$GITCONFIG_URL" -o "$INSTALL_PATH"

if ! git config --global --get-all include.path | grep -qF "$INSTALL_PATH"; then
    git config --global --add include.path "$INSTALL_PATH"
fi

echo "git-aliases installed: $INSTALL_PATH"
