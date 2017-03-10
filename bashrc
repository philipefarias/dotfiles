# Env variables
source ~/.dotfiles/bashfiles/exports.sh

# Aliases
source ~/.dotfiles/bashfiles/aliases.sh

# Completions
source ~/.dotfiles/bashfiles/completions.sh

# Prompt
source ~/.dotfiles/bashfiles/prompt.sh

# Recursive globbing for Bash 4
if shopt -q globstar; then
  shopt -s globstar
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
