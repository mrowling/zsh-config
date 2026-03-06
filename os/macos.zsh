# macOS-specific configuration

# Use GNU utilities if available (installed via Homebrew)
if command -v brew >/dev/null 2>&1; then
  # GNU coreutils
  if [[ -d "$(brew --prefix)/opt/coreutils/libexec/gnubin" ]]; then
    path_prepend "$(brew --prefix)/opt/coreutils/libexec/gnubin"
  fi
  
  # GNU findutils
  if [[ -d "$(brew --prefix)/opt/findutils/libexec/gnubin" ]]; then
    path_prepend "$(brew --prefix)/opt/findutils/libexec/gnubin"
  fi
  
  # GNU sed
  if [[ -d "$(brew --prefix)/opt/gnu-sed/libexec/gnubin" ]]; then
    path_prepend "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
  fi
fi

# macOS-specific aliases
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# Update ls alias for macOS (different flags than Linux)
if [[ "$(uname -s)" == "Darwin" ]]; then
  alias ls='ls -G'
fi
