###
# Env variables

# Fix macOS locale
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# gpg-agent need this
export GPG_TTY=$(tty)

# Set NeoVim as the default terminal editor
export EDITOR=nvim

# Add paths that should have been there by default
if [ "$(uname -sm)" == "Darwin arm64" ]; then # for Apple Silicon
  export PATH="/opt/homebrew/sbin:${PATH}"
  export PATH="/opt/homebrew/bin:${PATH}"
  export PATH="$(brew --prefix python)/libexec/bin:${PATH}"
  # Add Docker Desktop for Mac (docker)
  export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
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

# Bat (better cat) configuration
export BAT_THEME="Dracula"
export BAT_STYLE="numbers,changes,header"

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
alias h=history
alias x=exit

# Modern replacements (use new tools if available, fallback to standard)
if command -v eza &>/dev/null; then
  alias ls='eza --color=always --group-directories-first'
  alias ll='eza -la --color=always --group-directories-first --git'
  alias lt='eza --tree --level=2 --color=always'
else
  if [ "$(uname)" == "Darwin" ]; then
    alias ls='ls -G'
    alias ll='ls -lG'
  else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
  fi
fi

if command -v bat &>/dev/null; then
  alias cat='bat --style=auto'
  alias batcat='bat'
fi

if command -v fd &>/dev/null; then
  alias find='fd'
fi

if command -v httpie &>/dev/null; then
  alias http='http --pretty=all --print=hb'
  alias https='https --pretty=all --print=hb'
fi

# Always enable colored `grep` output
alias grep="grep -n --color"

# Development commands
if hub --version &>/dev/null; then
  alias git=hub
fi
alias pgr='pg_restore --no-acl --no-owner -h localhost -d'

# Platform-specific
if [ "$(uname)" == "Darwin" ]; then
  alias pinentry='pinentry-mac'
else
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
if [ "$(uname)" == "Darwin" ] && [ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
  . $(brew --prefix)/etc/profile.d/bash_completion.sh
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

# Use fd with fzf if available
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if [ -d "${HOME}/.asdf" ]; then
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
  . <(asdf completion bash)
fi

# Initialize zoxide (smart cd)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# Okta AWS CLI
if [[ -f "$HOME/.okta/bash_functions" ]]; then
  . "$HOME/.okta/bash_functions"
fi
if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
  PATH="$HOME/.okta/bin:$PATH"
fi

# Okta SSO autocomplete
_AWS_SSO_UTIL_COMPLETE_SCRIPT_DIR=~/.local/share/aws-sso-util
_AWS_SSO_UTIL_COMPLETE_SCRIPT=$_AWS_SSO_UTIL_COMPLETE_SCRIPT_DIR/complete.sh
if which aws-sso-util > /dev/null; then
  mkdir -p $_AWS_SSO_UTIL_COMPLETE_SCRIPT_DIR
  ({ _AWS_SSO_UTIL_COMPLETE=source_bash aws-sso-util > $_AWS_SSO_UTIL_COMPLETE_SCRIPT.tmp ;
    mv $_AWS_SSO_UTIL_COMPLETE_SCRIPT.tmp $_AWS_SSO_UTIL_COMPLETE_SCRIPT; } &)
  if [ -f $_AWS_SSO_UTIL_COMPLETE_SCRIPT ]; then
    source $_AWS_SSO_UTIL_COMPLETE_SCRIPT
  fi
fi
