export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git 
  zsh-autosuggestions  
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

source ~/.zsh_aliases
