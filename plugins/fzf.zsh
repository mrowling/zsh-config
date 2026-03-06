# FZF - fuzzy finder integration
# https://github.com/junegunn/fzf

# Source fzf if installed via package manager
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Or via Homebrew
if command -v brew >/dev/null 2>&1; then
  if [[ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]]; then
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
  fi
  if [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  fi
fi

# FZF configuration
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
