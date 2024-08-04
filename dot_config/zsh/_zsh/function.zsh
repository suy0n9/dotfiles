# aws-current - print current aws profile
aws-current() {
    echo "${AWS_PROFILE}"
}

# ls commit date
ls-commit() {
    git ls-files $1 | xargs -I{} bash -c 'git log -1 --format="%ai {}" {}'
}

# git worktree add command
gwkt() {
    GIT_CDUP_DIR=$(git rev-parse --show-cdup)
    git worktree add ${GIT_CDUP_DIR}git-worktrees/$1 -b $1
}
