# Python environment configuration

# uv - Fast Python package manager
# https://github.com/astral-sh/uv
if command -v uv >/dev/null 2>&1; then
  # Enable uv completions
  eval "$(uv generate-shell-completion zsh 2>/dev/null)"
  
  # Alias uvx for convenience (already installed, but make sure it's in path)
  alias uvr='uv run'
  alias uvi='uv init'
  alias uva='uv add'
fi

# pipx - Install Python applications in isolated environments
if command -v pipx >/dev/null 2>&1; then
  # pipx completions
  eval "$(register-python-argcomplete pipx 2>/dev/null)"
fi
