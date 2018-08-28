zplug 'zplug/zplug', hook-build:'zplug --self-manage'

#zplug "themes/candy", from:oh-my-zsh
#zplug "dracula/zsh", as:theme
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
