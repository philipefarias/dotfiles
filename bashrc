# Env variables
source ~/.dotfiles/bashfiles/exports.sh

# Aliases
source ~/.dotfiles/bashfiles/aliases.sh

# Completions for bash, git, rvm, rubygems, etc.
source ~/.dotfiles/bashfiles/completions.sh

# Custom prompt
source ~/.dotfiles/bashfiles/prompt.sh

# Ruby Version Manager
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
