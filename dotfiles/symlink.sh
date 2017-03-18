#!/bin/sh

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    # check symlink & unlink
    [[ -L ~/$f ]] && unlink ~/$f

    # check dotfiles & archive
    if [ -e ~/$f ]; then
        echo "$f is already exists."

        TIMESTAMP=`date +%Y%m%d%H%M`
        backupName="${f}_backup_${TIMESTAMP}"

        mv ~/$f ~/$backupName
        echo "Archived dotfiles ~/$f -> ~/$backupName"
    fi

    # set symlink
    filePath="$HOME/mac_setup/dotfiles/${f}"
    ln -s $filePath ~/$f
    echo "create symbolic link [ $f -> $filePath ]"
done