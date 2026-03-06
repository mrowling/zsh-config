# killport: Kill process listening on a specific port
killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port>"
    return 1
  fi
  
  if command -v lsof >/dev/null 2>&1; then
    lsof -i :"$1" -t | xargs kill -9 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "Killed process on port $1"
    else
      echo "No process found on port $1"
    fi
  else
    echo "Error: lsof command not found"
    return 1
  fi
}
