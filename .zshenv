# zmodload zsh/zprof

## 重複パスを登録しない
typeset -U path PATH cdpath fpath manpath

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug

# autoload
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# setting for go
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin

# Editor
export EDITOR=vim
