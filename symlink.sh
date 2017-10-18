#!/bin/sh

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".swp" ]] && continue

    # check symlink & unlink
    [[ -L ~/$f ]] && unlink ~/$f

    # check dotfiles & archive
    if [ -e ~/$f ]; then
        echo "$f is already exists."

        TIMESTAMP=`date +%Y%m%d%H%M`
        backupName=${f}_backup_${TIMESTAMP}

        mv ~/$f ~/$backupName
        echo "Archived dotfile ~/$f -> ~/$backupName"
    fi

    # set symlink
    filePath=$HOME/dev/src/github.com/suy0n9/dotfiles/${f}
    ln -sv $filePath ~/$f
    echo "create symbolic link [ $f -> $filePath ]"
done