# zmodload zsh/zprof

## 重複パスを登録しない
typeset -U path PATH cdpath fpath manpath

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug

# autoload
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


# history
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# setting for go
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin

# Editor
export EDITOR=vim

# LANGUAGE
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"

# Setting for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
