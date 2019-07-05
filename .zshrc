# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

zstyle ':completion:*:default' menu select=1 # 補完候補のカーソル選択を有効
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 保管時にcolorを有効
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字/小文字を区別しない

# local config
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# ---------------------------------
# alias
# ---------------------------------
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias gitconfig="vim ~/.gitconfig"

# go
alias gore='gore -autoimport'

# ghq
alias src='cd $(ghq root)'

# ls
alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -la'
alias lt='ls -ltr'

# ---------------------------------
# setopt
# ---------------------------------
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd

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

# ---------------------------------
# Plugin
# ---------------------------------
source $ZPLUG_HOME/init.zsh

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

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

# ---------------------------------
# Bind key
# ---------------------------------

# like a emacs bind
bindkey -e

bindkey '^]' peco-src
bindkey '^r' peco-select-history

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

# peco history
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  #zle clear-screen
}
zle -N peco-select-history

# fzf
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

# zprof
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi
