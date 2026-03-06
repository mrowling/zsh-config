# WSL (Windows Subsystem for Linux) specific configuration

# Source the Linux config first
if [[ -f "$ZSH_CONFIG_DIR/os/linux.zsh" ]]; then
  source "$ZSH_CONFIG_DIR/os/linux.zsh"
fi

# WSL-specific settings
export BROWSER='wslview'

# Windows interop - access Windows commands
if command -v cmd.exe >/dev/null 2>&1; then
  alias cmd='cmd.exe'
  alias powershell='powershell.exe'
  alias pwsh='pwsh.exe'
fi

# WSL clipboard integration (if wslu is installed)
if command -v wslview >/dev/null 2>&1; then
  alias open='wslview'
fi

# Windows path helpers
alias cdd='cd /mnt/c/Users/$USER/Downloads'
alias cdh='cd /mnt/c/Users/$USER'

# Fix for WSL2 clock drift
alias fix-time='sudo hwclock -s'
