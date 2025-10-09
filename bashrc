###
# Env variables

# Fix macOS locale
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# gpg-agent need this
export GPG_TTY=$(tty)

# Add paths that should have been there by default
if [ "$(uname -sm)" == "Darwin arm64" ]; then # for Apple Silicon
  export PATH="/opt/homebrew/sbin:${PATH}"
  export PATH="/opt/homebrew/bin:${PATH}"
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
else
  export PATH="/usr/local/opt/libpq/bin:$PATH"
fi
export PATH="/usr/local/sbin:${PATH}"
export PATH="/usr/local/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

# Enable globstar (**) to recurse all directory levels
shopt -s globstar


###
# Aliases

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
if hub --version &>/dev/null; then
  alias git=hub # wrapper that makes git better with github
fi
alias pgr='pg_restore --no-acl --no-owner -h localhost -d'

# For those whose miss the macOS "open"
if [ ! "$(uname)" == "Darwin" ]; then
  alias open='xdg-open &>/dev/null'
fi


###
# Util functions

# .env loading in the shell
source_env () {
  set -a
  [ -f .env ] && . .env
  set +a
}


###
# Completions

# Must have Homebrew installed and 'bash_completion' with it
if [ "$(uname)" == "Darwin" ] && [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi


###
# Prompt

# Using bash-git-prompt for an informative git prompt for bash

# Arch Linux configuration
if [ -f /usr/lib/bash-git-prompt/gitprompt.sh ]; then
  source /usr/lib/bash-git-prompt/gitprompt.sh

# Homebrew configuration
elif [ "$(uname)" == "Darwin" ] && [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi


###
# Other stuff

# Recursive globbing for Bash 4
if shopt -q globstar; then
  shopt -s globstar
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -d "${HOME}/.asdf" ]; then
  . "$(brew --prefix asdf)/libexec/asdf.sh"
  . "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
fi

# Okta AWS CLI
if [[ -f "$HOME/.okta/bash_functions" ]]; then
  . "$HOME/.okta/bash_functions"
fi
if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
  PATH="$HOME/.okta/bin:$PATH"
fi
