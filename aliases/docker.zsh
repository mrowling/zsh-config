# Docker aliases

if command -v docker >/dev/null 2>&1; then
  alias d='docker'
  alias dc='docker compose'
  alias dps='docker ps'
  alias dpsa='docker ps -a'
  alias di='docker images'
  alias dex='docker exec -it'
  alias dl='docker logs'
  alias dlf='docker logs -f'
  alias drm='docker rm'
  alias drmi='docker rmi'
  alias dstop='docker stop'
  alias dstart='docker start'
fi
