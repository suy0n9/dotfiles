#!/bin/bash

# vim-plug
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# vim color scheme
if [ ! -f "${HOME}/.vim/colors/Tomorrow-Night-Bright.vim" ]; then
  curl -fLo ~/.vim/colors/Tomorrow-Night-Bright.vim --create-dirs \
    https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Bright.vim
fi
# Tmux Plugin Manager
if [ ! -d "$XDG_DATA_HOME/tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$XDG_DATA_HOME"/tmux/plugins/tpm
fi

