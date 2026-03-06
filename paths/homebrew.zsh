# Homebrew PATH configuration
# Supports both Intel and Apple Silicon Macs

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Apple Silicon
  if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  # Intel Mac
  elif [[ -d "/usr/local/Homebrew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  
  # Linuxbrew
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
