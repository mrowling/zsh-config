# Editor configuration
# Set default editor based on availability

if command -v code >/dev/null 2>&1; then
  export EDITOR="code --wait"
  export VISUAL="code --wait"
elif command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  export VISUAL="nvim"
elif command -v vim >/dev/null 2>&1; then
  export EDITOR="vim"
  export VISUAL="vim"
else
  export EDITOR="vi"
  export VISUAL="vi"
fi
