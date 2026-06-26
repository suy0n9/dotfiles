#!/bin/bash

set -eu

if ! command -v brew &>/dev/null; then
    echo '[INFO] ************ Installing Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

echo '[INFO] ************ Installing with brew bundle'
brew bundle --file="$HOME/.Brewfile"
brew cleanup
