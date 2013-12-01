# Add paths that should have been there by default
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/usr/local/bin
export PATH="~/bin:$PATH"

# Unbreak broken, non-colored terminal
export TERM='xterm-256color'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend
