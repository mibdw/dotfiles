export ZSH="$HOME/.oh-my-zsh"
export WINIT_X11_SCALE_FACTOR=1.66 alacritty

alias nvim="nvim --listen ~/.cache/nvim/server.pipe"

plugins=(
  git 
  zsh-autosuggestions  
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

source ~/.zsh_aliases
