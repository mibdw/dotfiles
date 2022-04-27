export TERM="xterm-256color" 
export EDITOR="vim"
export LC_ALL="en_US.UTF-8"

set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set MANPATH $NPM_PACKAGES/share/man $MANPATH  

alias tmux='tmux -u'

alias xba='xbacklight -set'

source ~/.bash_aliases
