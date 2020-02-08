function peco-src() {
    local src=$(ghq list | sort | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        src=$(ghq list --full-path --exact $src)
        BUFFER="cd $src"
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
