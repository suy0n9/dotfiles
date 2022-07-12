# --------------------------------------------------------------------
# General
# --------------------------------------------------------------------
# Auto complie
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

for f (~/dev/src/github.com/suy0n9/dotfiles/zsh/*.zsh) source "${f}"

# local config
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# enable fuzzy auto-completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$(uname -m)" == arm64 ]]; then
    BREW_PREFIX=/opt/homebrew
elif [[ "$(uname -m)" == x86_64 ]]; then
    BREW_PREFIX=/usr/local
fi
# --------------------------------------------------------------------
# Completion
# --------------------------------------------------------------------
FPATH=$BREW_PREFIX/share/zsh/site-functions:$FPATH
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
    compinit
else
    compinit -C
fi

# menu select
zstyle ':completion:*:default' menu select=1

# Enable list color
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# change the path color
zstyle :prompt:pure:path color cyan

# --------------------------------------------------------------------
# Environment variables
# --------------------------------------------------------------------
typeset -U path fpath manpath

export LANG=en_US.UTF-8
export EDITOR=vim

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


path=(
    $BREW_PREFIX/opt/coreutils/libexec/gnubin(N-/) # coreutils
    $BREW_PREFIX/opt/findutils/libexec/gnubin(N-/) # findutils
    $BREW_PREFIX/opt/gnu-sed/libexec/gnubin(N-/) # sed
    $BREW_PREFIX/opt/gnu-tar/libexec/gnubin(N-/) # tar
    $BREW_PREFIX/opt/grep/libexec/gnubin(N-/) # grep
    $GOPATH/bin(N-/) # go
    $HOME/.poetry/bin(N-/) # python
    $path
)

manpath=(
    $BREW_PREFIX/opt/coreutils/libexec/gnuman(N-/) # coreutils
    $BREW_PREFIX/opt/findutils/libexec/gnuman(N-/) # findutils
    $BREW_PREFIX/opt/gnu-sed/libexec/gnuman(N-/) # sed
    $BREW_PREFIX/opt/gnu-tar/libexec/gnuman(N-/) # tar
    $BREW_PREFIX/opt/grep/libexec/gnuman(N-/) # grep
    $manpath
)

# setting for go
export GOPATH=$HOME/dev

# --------------------------------------------------------------------
# History
# --------------------------------------------------------------------
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt hist_ignore_all_dups  # Remove old command from list if history list command is duplicated
setopt hist_ignore_dups # Ignore duplicate history
setopt hist_ignore_space # Remove from history list if starting from space
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to the history list.
setopt share_history # Share history

# https://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    [[ ${#line} -ge 5
        && ${cmd} != (l[sal])
        && ${cmd} != (cd)
        && ${cmd} != (man)
    ]]
}

# --------------------------------------------------------------------
# Options
# --------------------------------------------------------------------
# Enable display of Japanese file name
setopt print_eight_bit

# Make cd push the old directory onto the directory stack. 'cd -<TAB>'
setopt auto_pushd


setopt nonomatch

setopt nobeep

# --------------------------------------------------------------------
# Alias
# --------------------------------------------------------------------
# diff
if [[ -x `which colordiff` ]]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

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

# list and select k8s pods with fzf
# e.g.
#   kubectl exec -it P bash
alias -g P='$(kubectl get po | fzf | awk "{print \$1}")'

alias lg='lazygit'

alias sss='source ~/.zshrc'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'

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
source $BREW_PREFIX/opt/zinit/zinit.zsh

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

zinit wait lucid blockf light-mode for \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-completions

zinit wait lucid light-mode for \
        zdharma-continuum/fast-syntax-highlighting \
        zsh-users/zsh-history-substring-search

# other
# --------------------------------------------------------------------
# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"

# asdf
. $BREW_PREFIX/opt/asdf/libexec/asdf.sh

# aws-current - print current aws profile
aws-current () {
    echo "${AWS_PROFILE}"
}

# ls commit date
ls-commit() {
    git ls-files $1 | xargs -I{} bash -c 'git log -1 --format="%ai {}" {}'
}

# git worktree add command
gwkt() {
    GIT_CDUP_DIR=`git rev-parse --show-cdup`
    git worktree add ${GIT_CDUP_DIR}git-worktrees/$1 -b $1
}

# Use zprof
if (which zprof > /dev/null 2>&1) ;then
    zprof | less
fi
