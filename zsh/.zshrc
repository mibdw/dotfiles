export ZSH="$HOME/.oh-my-zsh"
export WINIT_X11_SCALE_FACTOR=1.66 alacritty

plugins=(
  git 
  zsh-autosuggestions  
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

alias ls="eza"

source ~/.zsh_aliases

eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
	fd --hidden --exclude .git "$1" 
}

_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git "$1" 
}
