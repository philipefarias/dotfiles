# Must have Homebrew installed and 'bash_completion' with it
if [ "$(uname)" == "Darwin" ] && [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi
