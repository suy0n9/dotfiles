#!/bin/bash

set -eu

if ! (type brew > /dev/null 2>&1); then
    echo '[INFO] ************ Installing Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo '[INFO] ************ Homebrew is already exist'
fi

echo '[INFO] ************ Installing with brew bundle'
brew bundle
brew cleanup
