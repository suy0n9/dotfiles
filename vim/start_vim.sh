#!/bin/sh

DIR=$HOME/.vim
LINK_PATH=$HOME/mac_setup/vim
TARGET_DIR=(rc colors)

# check dir
for d in "${TARGET_DIR[@]}"
do
    if [ -e $DIR/$d ]; then
        echo "$DIR/$d : already exists."
    else
        ln -s $LINK_PATH/$d $DIR/$d
        echo "$DIR/$d : created directory."
    fi
done
