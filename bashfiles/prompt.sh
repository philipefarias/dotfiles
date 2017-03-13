# # #
# Using bash-git-prompt for an informative git prompt for bash

# Arch Linux configuration
if [ -f /usr/lib/bash-git-prompt/gitprompt.sh ]; then
  source /usr/lib/bash-git-prompt/gitprompt.sh

# Homebrew configuration
elif [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
