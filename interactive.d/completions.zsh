# Interactive-only configuration: completions and keybindings

# Enable completion system with caching for performance
autoload -Uz compinit

# Only regenerate compdump once per day for better performance
# Check if .zcompdump is older than 24 hours
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C  # Skip security check for faster loading
fi

# Completion options
setopt AUTO_MENU           # Show completion menu on tab
setopt COMPLETE_IN_WORD    # Complete from both ends of word
setopt ALWAYS_TO_END       # Move cursor to end after completion

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion (uses same colors as ls)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Menu selection
zstyle ':completion:*' menu select

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS      # Don't record duplicates
setopt HIST_IGNORE_SPACE     # Don't record commands starting with space
setopt SHARE_HISTORY         # Share history between sessions
setopt EXTENDED_HISTORY      # Record timestamp of command

# Keybindings - use emacs mode
bindkey -e

# Better history search with arrow keys
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search     # Up arrow
bindkey '^[[B' down-line-or-beginning-search   # Down arrow
