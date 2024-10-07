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
    # Check if the current directory is a git repository
    git rev-parse --is-inside-work-tree &>/dev/null
    if [ $? -ne 0 ]; then
        echo "fatal: Not a git repository."
        return 1
    fi

    if [ -z "$1" ]; then
        echo "Usage: gwkt <branch-name>"
        return 1
    fi

    # Get the root directory of the git repository
    local gitRootDir=$(git rev-parse --show-toplevel)

    # Define the worktree directory path
    local worktreeDir="${gitRootDir}/git-worktrees/$1"

    # Create the worktree and the branch
    git worktree add "${worktreeDir}" -b "$1"

    if [ $? -eq 0 ]; then
        echo "Worktree added at: ${worktreeDir}"
    else
        echo "Failed to add worktree."
    fi
}
