# Node.js tooling paths

# NVM (Node Version Manager) - Lazy loaded for performance
# This dramatically improves shell startup time (~5s -> ~0.01s)
export NVM_DIR="$HOME/.nvm"

# Lazy-load NVM - only initialize when nvm command is used
nvm() {
  unset -f nvm node npm npx
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi
  if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
  fi
  nvm "$@"
}

# Lazy-load node, npm, npx as well
node() {
  unset -f nvm node npm npx
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi
  node "$@"
}

npm() {
  unset -f nvm node npm npx
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi
  npm "$@"
}

npx() {
  unset -f nvm node npm npx
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi
  npx "$@"
}

# Add default node path EARLY so npm/node binaries are found before lazy-load
# This prevents Windows Node from being used in WSL
if [[ -d "$NVM_DIR/versions/node" ]]; then
  # Try to find nvm default alias first, fall back to latest version
  if [[ -L "$NVM_DIR/alias/default" ]]; then
    DEFAULT_NODE_VERSION=$(cat "$NVM_DIR/alias/default" 2>/dev/null)
    DEFAULT_NODE_PATH="$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION"
  else
    # Find the latest node version
    DEFAULT_NODE_PATH=$(find "$NVM_DIR/versions/node" -maxdepth 1 -name 'v*' | sort -V | tail -1)
  fi
  if [[ -n "$DEFAULT_NODE_PATH" && -d "$DEFAULT_NODE_PATH/bin" ]]; then
    path_prepend "$DEFAULT_NODE_PATH/bin"
  fi
fi

# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
path_prepend "$PNPM_HOME"

# Note: For pnpm completions, add to interactive.d/:
# pnpm completion zsh > ~/.zsh/interactive.d/_pnpm-completion.zsh
# Or run: pnpm completion zsh | source /dev/stdin (in your shell)

# Bun
export BUN_INSTALL="$HOME/.bun"
path_prepend "$BUN_INSTALL/bin"

# Bun completions moved to interactive.d/bun.zsh for performance
