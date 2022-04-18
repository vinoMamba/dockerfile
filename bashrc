[ `alias | grep "^ls=" | wc -l` != 0 ] && unalias ls
alias gst='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gl='git pull'
alias gp='git push'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- | less"
alias ls='exa'
alias ll='ls -lh'
alias la='ls -alh'

alias vim = 'nvim'
alias vi = 'nvim'
alias nvim = 'nvim'