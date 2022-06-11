#!/bin/bash

set -eu

echo '[INFO] ************ Installing Go pakages'

PKGS=(
    golang.org/x/tools/cmd/godoc
    golang.org/x/tools/cmd/goimports
    golang.org/x/tools/cmd/gorename
    golang.org/x/tools/cmd/guru

    github.com/rogpeppe/godef
)

for pkg in ${PKGS[@]}
do
    go get -u -v $pkg
done

# https://github.com/golang/tools/blob/master/gopls/doc/user.md
GO111MODULE=on go get golang.org/x/tools/gopls@latest
