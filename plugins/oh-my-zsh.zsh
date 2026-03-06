# Oh My Zsh integration (optional)
# Load Oh My Zsh if it's installed

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  export ZSH="$HOME/.oh-my-zsh"
  
  # Theme
  ZSH_THEME="agnoster"
  
  # Plugins (keep it minimal for performance)
  plugins=(git)
  
  # Load Oh My Zsh
  source "$ZSH/oh-my-zsh.sh"
fi
