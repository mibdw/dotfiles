export TERM="xterm-256color" 
export EDITOR="vim"
export LC_ALL="en_US.UTF-8"

alias tmux='tmux -u'

alias xba='xbacklight -set'

source ~/.bash_aliases

function fish_greeting
  ~/.config/food --random
end
funcsave fish_greeting
