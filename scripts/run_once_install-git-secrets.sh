#!/bin/bash

if ! (type git-secrets >/dev/null 2>&1); then
    echo '[INFO] ************ git-secrets not found, skipping'
    exit 0
fi

echo '[INFO] ************ Setting up git-secrets templates'
git secrets --install ~/.git-templates/git-secrets --force
git secrets --register-aws --global
