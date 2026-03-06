# Modular Zsh Configuration

A clean, extensible zsh configuration that works across macOS, Linux, and WSL.

## Structure

```
~/.zsh/
├── env/              # Environment variables
├── paths/            # PATH modifications
├── aliases/          # Command aliases
├── functions/        # Shell functions
├── plugins/          # Plugin integrations
├── prompt/           # Prompt configuration
├── interactive.d/    # Interactive-only config (completions, keybindings)
├── os/              # OS-specific settings
├── host/            # Host-specific settings
├── local/           # Local overrides (gitignored)
├── local.zsh        # Local config file (gitignored)
└── local.zsh.example # Template for local config
```

## Installation

### Quick Install

```bash
# Clone this repository to ~/.zsh
git clone <your-repo-url> ~/.zsh

# Run the install script
cd ~/.zsh
./install.sh
```

The install script will:
- Backup your existing `~/.zshrc` (if it exists) with a timestamp
- Copy the new `zshrc` file to `~/.zshrc`
- Provide instructions for next steps

### Manual Install

1. Clone or copy this repository to `~/.zsh`
2. Backup your existing `~/.zshrc`: `cp ~/.zshrc ~/.zshrc.backup`
3. Copy the new config: `cp ~/.zsh/zshrc ~/.zshrc`
4. Copy `local.zsh.example` to `local.zsh` and add your secrets/tokens
5. Restart your shell or run `source ~/.zshrc`

### Post-Installation

1. **Reload your shell**: `source ~/.zshrc`
2. **Add secrets**: Copy `local.zsh.example` to `local.zsh` and add your tokens/secrets
3. **Host-specific config**: Create `host/$(hostname).zsh` for machine-specific settings

## Load Order

Files are loaded in this order:

1. **env/** - Environment variables (EDITOR, LANG, etc.)
2. **paths/** - PATH modifications (node, go, homebrew, etc.)
3. **aliases/** - Command aliases (git, docker, kubernetes, etc.)
4. **functions/** - Shell functions (mkcd, extract, killport, etc.)
5. **plugins/** - Plugin integrations (oh-my-zsh, zoxide, fzf, etc.)
6. **prompt/** - Prompt/theme configuration
7. **interactive.d/** - Interactive-only (completions, keybindings) - only loaded for interactive shells
8. **os/** - OS-specific config (automatically detects macOS/Linux/WSL)
9. **host/** - Host-specific config (named by hostname)
10. **local.zsh** and **local/** - Local overrides (not tracked in git)

## Adding Configuration

### Add a new alias

Create a file in `aliases/` directory:

```bash
# aliases/myapp.zsh
alias myapp='command --with-flags'
```

### Add a new function

Create a file in `functions/` directory:

```bash
# functions/myfunction.zsh
myfunction() {
  echo "Hello from my function"
}
```

### Add environment variables

Create a file in `env/` directory:

```bash
# env/myapp.zsh
export MYAPP_CONFIG="$HOME/.config/myapp"
```

### Add to PATH

Create a file in `paths/` directory:

```bash
# paths/myapp.zsh
path_prepend "$HOME/.myapp/bin"
```

### Add OS-specific config

Edit the appropriate file in `os/`:
- `os/macos.zsh` - macOS only
- `os/linux.zsh` - Linux only
- `os/wsl.zsh` - WSL only

### Add host-specific config

Create a file named after your hostname:

```bash
# Get your hostname
hostname

# Create config file
touch host/$(hostname).zsh
```

### Add secrets/tokens

Add them to `local.zsh` (this file is gitignored):

```bash
# local.zsh
export MY_SECRET_TOKEN="secret123"
export API_KEY="abc123"
```

## Helper Functions

The main `.zshrc` provides these helper functions:

- `try_source <file>` - Safely source a file with error handling
- `path_prepend <dir>` - Add directory to beginning of PATH (no duplicates)
- `path_append <dir>` - Add directory to end of PATH (no duplicates)
- `is_interactive` - Check if running in interactive mode

## Included Functions

- `mkcd <dir>` - Create directory and cd into it
- `extract <file>` - Extract various archive types
- `killport <port>` - Kill process listening on a port

## OS Detection

The configuration automatically detects your OS:

- **macOS** - Loads `os/macos.zsh`
- **Linux** - Loads `os/linux.zsh`
- **WSL** - Loads `os/wsl.zsh` (which also sources `os/linux.zsh`)

## Plugins

Supported plugins (loaded if installed):

- Oh My Zsh
- Zoxide (smarter cd)
- FZF (fuzzy finder)
- envman (environment manager)

## Performance

- Non-interactive shells skip `interactive.d/` loading
- Plugin loading is conditional (only loads if command exists)
- Path helpers prevent duplicates
- Fail-safe loading continues even if a file errors

## Maintenance

### Update from git

```bash
cd ~/.zsh
git pull
source ~/.zshrc
```

### Check what's loaded

```bash
# See all loaded files
echo $fpath

# Check PATH
echo $PATH | tr ':' '\n'
```

### Debug loading issues

The `try_source` function will print warnings if files fail to load.

## Customization

This configuration is designed to be customized. Feel free to:

- Add new directories for different types of config
- Modify the load order in `~/.zshrc`
- Create your own helper functions
- Organize files however makes sense for you

## Security

- Never commit `local.zsh` or files in `local/` to git
- These are automatically ignored via `.gitignore`
- Store all secrets, tokens, and machine-specific config there

## Portability

This configuration works across:

- macOS (Intel and Apple Silicon)
- Linux (Ubuntu, Debian, Fedora, etc.)
- WSL (Windows Subsystem for Linux)

The same files can be used on all your machines, with machine-specific config in `local.zsh` or `host/` directory.
