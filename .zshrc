# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
source $ZPLUG_HOME/init.zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load


zstyle ':completion:*:default' menu select=1

# read settings
for f in ~/.zsh/*.zsh
do
    source $f
done


# anyenv
# if [ -d $HOME/.anyenv ] ; then
#     export PATH="$HOME/.anyenv/bin:$PATH"
#     eval "$(anyenv init -)"
#     for D in `ls $HOME/.anyenv/envs`
#     do
#         export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
#     done
#  fi

# gvm
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# pyenv
PYENV_ROOT=$HOME/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"


# peco src
function peco-src() {
    local src=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        BUFFER="cd ${GOPATH}/src/$src"
        zle accept-line
    fi
    zle -R -c
}
zle -N peco-src
bindkey '^]' peco-src

# peco history
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# local config
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# zprof
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi
