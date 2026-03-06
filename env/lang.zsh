# Language and locale settings

# Set language environment if not already set
if [[ -z "$LANG" ]]; then
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi
