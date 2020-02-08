export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=$(fzf --query="$1" --multi --select-1 --exit-0)
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

# fssh - ssh to the selected host
fssh() {
    local sshLoginHost
    sshLoginHost=$(cat ~/.ssh/config | grep -i ^host | grep -v '*' | awk '{print $2}' | fzf)

    if [ -z "$sshLoginHost" ]; then
        return 1
    fi

    ssh ${sshLoginHost}
}

# awx - switch to the selected aws profile
awx() {
    local prof=$(cat ~/.aws/config | awk '/\[.+\]/ { print $2 }'| tr -d "]" | fzf)
    if [ -z "$prof" ]; then
        return 1
    fi

    export AWS_PROFILE=${prof}
    echo export AWS_PROFILE=${prof}
}
