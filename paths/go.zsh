# Go language paths

# Go root and path
if [[ -d "/usr/local/go" ]]; then
  export GOROOT="/usr/local/go"
  path_prepend "$GOROOT/bin"
fi

# Go path for user binaries
export GOPATH="$HOME/go"
path_append "$GOPATH/bin"
