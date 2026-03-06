# Linux-specific configuration

# Enable color support for ls and other tools
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Linux-specific aliases
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# systemd shortcuts
alias sctl='systemctl'
alias sctlu='systemctl --user'
alias jctl='journalctl'
