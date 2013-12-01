# RVM completion
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion

# Must have Homebrew installed and 'bash_completion' with it
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Rubygems completion from Nando Vieira (fnando)
source ~/.bash/lib/completions/gem_completion.sh
