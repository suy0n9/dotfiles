#!/bin/sh

DIR=$HOME/.vim/rc
FILEPATH=$HOME/mac_setup/vim/rc

# check rc dir
if [ -e $DIR ]; then
    echo "$DIR is already exists."
else
    ln -s $FILEPATH $DIR
    echo "create $DIR"
fi
