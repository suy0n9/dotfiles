export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

function fzf-ghq() {
    local fzf_command="fzf"
    if type fzf-tmux > /dev/null; then
        fzf_command="fzf-tmux -p 80%"
    fi
    fzf_command+=" "
    # fzf_command+=$(cat << "EOF"
    #     --preview '
    #       ( (type bat > /dev/null) &&
    #         bat --color=always \
    #           --theme=Nord \
    #           --line-range :200 $(ghq root)/{}/README.* \
    #         || (cat {} | head -200) ) 2> /dev/null
    #     ' \
    #     --preview-window 'down,80%,wrap,+3/2,~3'
    fzf_command+=$(cat << "EOF"
        --preview '
            tree -aC -L 1 $(ghq root)/{} | head -200
        ' \
        --preview-window 'right,wrap,~1'
EOF
)

    local src=$(ghq list | eval $fzf_command)

    if [ -n "$src" ]; then
        src=$(ghq list --full-path --exact $src)
        BUFFER="cd $src"
        zle accept-line
    fi
    zle -R -c
}
zle -N fzf-ghq

# fzf history
function fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf-tmux -p -w80% --exact --no-sort --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=$(fzf --query="$1" --multi --select-1 --exit-0 \
      --preview '
        bat --style=numbers \
            --color=always \
            --theme=Nord \
            --line-range :200 {} \
            '
        )
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

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# cd git worktree
cdwkt() {
    # Check if the current directory is a git repository
    git rev-parse &>/dev/null
    if [ $? -ne 0 ]; then
        echo fatal: Not a git repository.
        return
    fi

    local selectedWorkTreeDir=`git worktree list | fzf | awk '{print $1}'`

    if [ "$selectedWorkTreeDir" = "" ]; then
        # Ctrl-C.
        return
    fi

    cd ${selectedWorkTreeDir}
}

# fssh - ssh to the selected host
fssh() {
    local sshLoginHost
    sshLoginHost=$(cat ~/.ssh/config | grep -i ^host | grep -v '*' | awk '{print $2}' \
        |fzf \
        --preview 'batgrep {} ~/.ssh/config'
    )

    if [ -z "$sshLoginHost" ]; then
        return 1
    fi

    echo ssh ${sshLoginHost}
    ssh ${sshLoginHost}
}

# awx - switch to the selected aws profile
awx() {
    local prof=$(cat ~/.aws/config | awk '/\[.+\]/ {print $NF}'| tr -d "[]" | fzf)
    if [ -z "$prof" ]; then
        return 1
    fi

    export AWS_PROFILE=${prof}
    echo export AWS_PROFILE=${prof}
}
