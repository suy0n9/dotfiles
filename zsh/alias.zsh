# diff
if [[ -x `which colordiff` ]]; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

# go
alias gore='gore -autoimport'

# ghq
alias src='cd $(ghq root)'

# ls
if [[ -x `which exa` ]]; then
    alias ls='exa --icons'
    alias ll='exa -l --icons'
    alias la='exa -la --icons'
else
    alias ls='ls -GF'
    alias ll='ls -l'
    alias la='ls -la'
    alias lt='ls -ltr'
fi

# k8s
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kx='kubectx'
alias kn='kubens'

# list and select k8s pods with fzf
# e.g.
#   kubectl exec -it P bash
alias -g P='$(kubectl get po | fzf | awk "{print \$1}")'

alias lg='lazygit'

alias sss='source $ZDOTDIR/.zshrc'
alias vz='vim $ZDOTDIR/.zshrc'
alias vv='vim ~/.vim/vimrc'

# http status
alias "100"="echo 'Continue'"
alias "101"="echo 'Switching Protocols'"
alias "200"="echo 'OK'"
alias "201"="echo 'Created'"
alias "202"="echo 'Accepted'"
alias "203"="echo 'Non-Authoritative Information'"
alias "204"="echo 'No Content'"
alias "205"="echo 'Reset Content'"
alias "206"="echo 'Partial Content'"
alias "300"="echo 'Multiple Choices'"
alias "301"="echo 'Moved Permanently'"
alias "302"="echo 'Found'"
alias "303"="echo 'See Other'"
alias "304"="echo 'Not Modified'"
alias "305"="echo 'Use Proxy'"
alias "307"="echo 'Temporary Redirect'"
alias "400"="echo 'Bad Request'"
alias "401"="echo 'Unauthorized'"
alias "402"="echo 'Payment Required'"
alias "403"="echo 'Forbidden'"
alias "404"="echo 'Not Found'"
alias "405"="echo 'Method Not Allowed'"
alias "406"="echo 'Not Acceptable'"
alias "407"="echo 'Proxy Authentication Required'"
alias "408"="echo 'Request Timeout'"
alias "409"="echo 'Conflict'"
alias "410"="echo 'Gone'"
alias "411"="echo 'Length Required'"
alias "412"="echo 'Precondition Failed'"
alias "413"="echo 'Payload Too Large'"
alias "414"="echo 'URI Too Long'"
alias "415"="echo 'Unsupported Media Type'"
alias "416"="echo 'Range Not Satisfiable'"
alias "417"="echo 'Expectation Failed'"
alias "426"="echo 'Upgrade Required'"
alias "500"="echo 'Internal Server Error'"
alias "501"="echo 'Not Implemented'"
alias "502"="echo 'Bad Gateway'"
alias "503"="echo 'Service Unavailable'"
alias "504"="echo 'Gateway Timeout'"
alias "505"="echo 'HTTP Version Not Supported'"
