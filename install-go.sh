#!/bin/bash

set -eu

echo '[INFO] ************ Installing Go pakages'

PKGS=(
    golang.org/x/tools/cmd/godoc
    golang.org/x/tools/cmd/goimports
    golang.org/x/tools/cmd/gorename
    golang.org/x/tools/cmd/guru
    golang.org/x/tools/cmd/gopls

    github.com/rogpeppe/godef
)

for pkg in ${PKGS[@]}
do
    go get -u -v $pkg
done
