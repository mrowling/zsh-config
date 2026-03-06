# Minimal portable zsh entrypoint
# Loads modular configuration from ~/.zsh/
# Works across macOS, Linux, and WSL

# Set config directory
ZSH_CONFIG_DIR="${HOME}/.zsh"

# Helper: safely source files with error handling
try_source() {
  local f="$1"
  if [[ -r "$f" ]]; then
    source "$f" 2>/dev/null || {
      printf 'zsh: warning: failed to source %s\n' "$f" >&2
    }
  fi
}

# Helper: prepend to PATH without duplicates
path_prepend() {
  local dir="$1"
  [[ -d "$dir" ]] || return
  case ":$PATH:" in
    *":$dir:"*) return ;;
    *) PATH="$dir:$PATH" ;;
  esac
}

# Helper: append to PATH without duplicates
path_append() {
  local dir="$1"
  [[ -d "$dir" ]] || return
  case ":$PATH:" in
    *":$dir:"*) return ;;
    *) PATH="$PATH:$dir" ;;
  esac
}

# Helper: check if running interactively
is_interactive() { [[ $- == *i* ]]; }

# Load modular config in order
# 1. Environment variables
for file in "$ZSH_CONFIG_DIR"/env/*.zsh(N); do
  try_source "$file"
done

# 2. PATH modifications
for file in "$ZSH_CONFIG_DIR"/paths/*.zsh(N); do
  try_source "$file"
done

# 3. Aliases
for file in "$ZSH_CONFIG_DIR"/aliases/*.zsh(N); do
  try_source "$file"
done

# 4. Functions
for file in "$ZSH_CONFIG_DIR"/functions/*.zsh(N); do
  try_source "$file"
done

# 5. Plugins
for file in "$ZSH_CONFIG_DIR"/plugins/*.zsh(N); do
  try_source "$file"
done

# 6. Prompt
for file in "$ZSH_CONFIG_DIR"/prompt/*.zsh(N); do
  try_source "$file"
done

# 7. Interactive-only configuration (completions, keybindings, etc)
if is_interactive; then
  for file in "$ZSH_CONFIG_DIR"/interactive.d/*.zsh(N); do
    try_source "$file"
  done
fi

# 8. OS-specific configuration
OS="$(uname -s)"
case "$OS" in
  Darwin)
    try_source "$ZSH_CONFIG_DIR/os/macos.zsh"
    ;;
  Linux)
    if [[ -n "${WSL_DISTRO_NAME:-}" ]] || grep -qEi '(microsoft|wsl)' /proc/version 2>/dev/null; then
      try_source "$ZSH_CONFIG_DIR/os/wsl.zsh"
    else
      try_source "$ZSH_CONFIG_DIR/os/linux.zsh"
    fi
    ;;
esac

# 9. Host-specific configuration
try_source "$ZSH_CONFIG_DIR/host/$(hostname).zsh"

# 10. Local overrides (not tracked in git)
for file in "$ZSH_CONFIG_DIR"/local/*.zsh(N); do
  try_source "$file"
done
try_source "$ZSH_CONFIG_DIR/local.zsh"

# Export PATH for login shells
export PATH
