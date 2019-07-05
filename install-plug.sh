#!/bin/bash

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim color scheme
curl -fLo ~/.vim/colors/Tomorrow-Night-Bright.vim --create-dirs \
      https://raw.githubusercontent.com/chriskempson/vim-tomorrow-theme/master/colors/Tomorrow-Night-Bright.vim

# tmux plug
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
