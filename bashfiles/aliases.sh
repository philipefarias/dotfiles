# Basic commands
alias ..="cd .."
alias ...="cd ../.."
if [ "$(uname)" == "Darwin" ]; then
  alias ls='ls -G'
  alias ll='ls -lG'
else
  alias ls='ls --color=auto'
  alias ll='ls -l --color=auto'
fi
alias h=history
alias x=exit

# Always enable colored `grep` output
alias grep="grep -n --color"

# Dev commands
alias git=hub # wrapper that makes git better with github
alias pgr='pg_restore --no-acl --no-owner -h localhost -d'

# For those whose miss the macOS "open"
alias open='xdg-open &>/dev/null'
