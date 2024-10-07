export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# see: https://www.m3tech.blog/entry/dotfiles-bonsai#Tmux%E7%B7%A8
# Gitリポジトリを列挙する
widget::ghq::source() {
    local session color icon green="\e[32m" blue="\e[34m" reset="\e[m" checked="󰄲" unchecked="󰄱"
    local sessions=($(tmux list-sessions -F "#S" 2>/dev/null))

    ghq list | sort | while read -r repo; do
        session="${repo//[:. ]/-}"
        color="$blue"
        icon="$unchecked"
        if (( ${+sessions[(r)$session]} )); then
            color="$green"
            icon="$checked"
        fi
        printf "$color$icon %s$reset\n" "$repo"
    done
}
# GitリポジトリをFZFで選択する
widget::ghq::select() {
    local root="$(ghq root)"
    widget::ghq::source | fzf --exit-0 --ansi --preview="fzf-preview-git ${(q)root}/{+2}" --preview-window="right:60%" | cut -d' ' -f2-
}
# FZFで選択されたGitリポジトリにTmuxセッションを立てる
widget::ghq::session() {
    local selected="$(widget::ghq::select)"
    if [ -z "$selected" ]; then
        return
    fi

    local repo_dir="$(ghq list --exact --full-path "$selected")"
    local session_name="${selected//[:. ]/-}"

    if [ -z "$TMUX" ]; then
        # Tmuxの外にいる場合はセッションにアタッチする
        BUFFER="tmux new-session -A -s ${(q)session_name} -c ${(q)repo_dir}"
        zle accept-line
    elif [ "$(tmux display-message -p "#S")" = "$session_name" ] && [ "$PWD" != "$repo_dir" ]; then
        # 選択されたGitリポジトリのセッションにすでにアタッチしている場合はGitリポジトリのルートディレクトリに移動する
        BUFFER="cd ${(q)repo_dir}"
        zle accept-line
    else
        # 別のTmuxセッションにいる場合はセッションを切り替える
        tmux new-session -d -s "$session_name" -c "$repo_dir" 2>/dev/null
        tmux switch-client -t "$session_name"
    fi
    zle -R -c # refresh screen
}
zle -N widget::ghq::session

function fzf-ghq() {
    local fzf_command="fzf"
    if type fzf-tmux > /dev/null; then
        fzf_command="fzf-tmux -p 80%"
    fi
    fzf_command+=" "
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

# remove git worktree
rmwkt() {
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

    # Confirm removal
    echo "Are you sure you want to remove the worktree at '$selectedWorkTreeDir'? [y/N]"
    read -r confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        git worktree remove ${selectedWorkTreeDir}
        echo "Worktree at '$selectedWorkTreeDir' removed."
    else
        echo "Cancelled."
    fi
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
