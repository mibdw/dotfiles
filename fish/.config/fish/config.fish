export TERM="xterm-256color" 
export EDITOR="nvim"
export LC_ALL="en_US.UTF-8"

set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set MANPATH $NPM_PACKAGES/share/man $MANPATH  
set fish_greeting

alias tmux='tmux -u'
alias xba='xbacklight -set'
alias la='exa -la --group-directories-first'
alias ff='firefox'

source ~/.bash_aliases

