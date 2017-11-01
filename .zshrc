# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH


export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "themes/candy", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/git",   from:oh-my-zsh


# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi
zplug load


# autoload -U compinit && compinit -u
zstyle ':completion:*:default' menu select=1

# Example aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias gitconfig="vim ~/.gitconfig"
alias gore='gore -autoimport'
alias src='$(ghq root)'

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd

# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

## 重複パスを登録しない
typeset -U path cdpath fpath manpath

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

# export
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin

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

# work config
if [[ -f ~/work.zsh ]]; then
    source ~/work.zsh
fi

# zprof
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi
