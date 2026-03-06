# Installation Guide

This guide explains how to install the modular zsh configuration and all required development tools.

## Quick Install

```bash
# Clone the repository
git clone <your-repo-url> ~/.zsh

# Run the installer
cd ~/.zsh
./install.sh
```

## What Gets Installed

The install script will:

1. **Backup your existing `.zshrc`** (if it exists) with a timestamp
2. **Install the new modular `.zshrc`** from this repository
3. **Optionally install development tools:**
   - **NVM** (Node Version Manager) + Node.js LTS
   - **uv** (Fast Python package manager)
   - **Go** (latest stable version)
   - **Bun** (JavaScript runtime)
   - **GitHub CLI** (gh)

## Troubleshooting

### NVM not found after installation

```bash
# Manually source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Or reload shell
source ~/.zshrc
```

### Go not in PATH

```bash
# Add to your shell (should already be in paths/go.zsh)
export PATH=/usr/local/go/bin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

### uv not found

```bash
# uv installs to ~/.local/bin
# Make sure it's in your PATH
export PATH="$HOME/.local/bin:$PATH"
```

### Permission denied on install.sh

```bash
chmod +x ~/.zsh/install.sh
```

## Updating

To update your configuration:

```bash
cd ~/.zsh
git pull
source ~/.zshrc
```

## Platform-Specific Notes

### WSL2
- Docker requires Docker Desktop with WSL2 integration enabled
- Windows interop commands available in `os/wsl.zsh`

### macOS
- Uses GNU tools via Homebrew when available
- Supports both Intel and Apple Silicon

### Linux
- Uses apt/yum based on distribution
- Clipboard aliases map to xclip

## See Also

- [README.md](README.md) - Configuration structure and usage
- [DEPENDENCIES.md](DEPENDENCIES.md) - Complete dependency map
- [docs/uv-guide.md](docs/uv-guide.md) - uv quick reference
