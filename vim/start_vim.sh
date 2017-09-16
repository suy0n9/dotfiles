#!/bin/sh

DIR=rc

# check rc dir
if [ -e ~/.vim/$DIR ]; then
    echo "$DIR is already exists."
else
    mkdir ~/.vim/$DIR
    echo "create ~/.vim/$DIR"
fi


# set dein toml
for F in rc/*toml
do
    FILEPATH=$HOME/mac_setup/$F

    ln -s $FILEPATH $HOME/.vim/$F
    echo "create symlink [ $F -> $FILEPATH ]"
done
