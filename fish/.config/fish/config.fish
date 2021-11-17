export TERM="xterm-256color" 
export EDITOR="vim"
export LC_ALL="en_US.UTF-8"

alias l='exa -1a'
alias la='exa -la'
alias tmux='tmux -u'

alias lynx='lynx -lss=~/.config/lynx/lynx.lss -cfg=~/.config/lynx/lynx.cfg'
alias xba='xbacklight -set'

function ddg
  set searchTerm (string escape --style=url $argv)
  lynx -lss=~/.config/lynx/lynx.lss -cfg=~/.config/lynx/lynx.cfg 'https://lite.duckduckgo.com/lite?q='(echo $searchTerm)
end

function ggl
  set searchTerm (string escape --style=url $argv)
  lynx -lss=~/.config/lynx/lynx.lss -cfg=~/.config/lynx/lynx.cfg 'https://google.com/search?q='(echo $searchTerm)
end

source ~/.bash_aliases
