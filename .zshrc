# --------------------------------------------------------------------
# General
# --------------------------------------------------------------------
# local config
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# --------------------------------------------------------------------
# Environment variables
# --------------------------------------------------------------------
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export LANG=en_US.UTF-8
export EDITOR=vim
export ZPLUG_HOME=/usr/local/opt/zplug

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# setting for go
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin

# pyenv
PYENV_ROOT=$HOME/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"

# --------------------------------------------------------------------
# Completion
# --------------------------------------------------------------------
# Initialization
autoload -U compinit

# menu select
zstyle ':completion:*:default' menu select=1

# Enable list color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# change the path color
zstyle :prompt:pure:path color cyan

# --------------------------------------------------------------------
# Options
# --------------------------------------------------------------------
# Enable display of Japanese file name
setopt print_eight_bit

# Make cd push the old directory onto the directory stack. 'cd -<TAB>'
setopt auto_pushd

# Share history
setopt share_history

# Remove old command from list if history list command is duplicated
setopt hist_ignore_all_dups

# Ignore duplicate history
setopt hist_ignore_dups

# Remove from history list if starting from space
setopt hist_ignore_space

# Remove extra blanks from each command line being added to the history list.
setopt hist_reduce_blanks

# --------------------------------------------------------------------
# Alias
# --------------------------------------------------------------------
# go
alias gore='gore -autoimport'

# ghq
alias src='cd $(ghq root)'

# ls
alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -la'
alias lt='ls -ltr'

# k8s
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kx='kubectx'
alias kn='kubens'

# zsh
alias sss='source ~/.zshrc'
alias vz='vim ~/.zshrc'

# --------------------------------------------------------------------
# Bind key
# --------------------------------------------------------------------
# like a emacs bind
bindkey -e

bindkey '^]' peco-src
bindkey '^r' peco-select-history

# --------------------------------------------------------------------
# Plugin
# --------------------------------------------------------------------
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async", from:github, use:"async.zsh"
zplug "sindresorhus/pure", use:"pure.zsh", from:github, as:theme

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# Peco
# --------------------------------------------------------------------
function peco-src() {
    local src=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        BUFFER="cd ${GOPATH}/src/$src"
        zle accept-line
    fi
    zle -R -c
}
zle -N peco-src

# peco history
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  #zle clear-screen
}
zle -N peco-select-history

# fzf
# --------------------------------------------------------------------
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Settings
# --------------------------------------------------------------------
# Enables kubectl completion
source <(kubectl completion zsh)
