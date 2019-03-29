#!/bin/sh

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitconfig.local" ]] && continue

    echo "===$f==="

    # set symlink
    ln -sv $PWD/$f $HOME
done

# set symlink for flake8
FLAKE8PATH=".config/flake8"
echo "===$FLAKE8PATH==="
ln -s $PWD/$FLAKE8PATH ~/$FLAKE8PATH

