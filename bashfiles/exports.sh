# Add paths that should have been there by default
export PATH="/usr/local/sbin:${PATH}"
export PATH="/usr/local/bin:${PATH}"
export PATH="${HOME}/.cabal/bin:${PATH}"
export PATH="${HOME}/.bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'
#export LSCOLORS='ExGxBxDxCxEgEdxbxgxcxd'
# Better colors to match the solarized theme
export LSCOLORS='gxfxbEaEBxxEhEhBaDaCaD'
export GREP_OPTIONS='--color'

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend
