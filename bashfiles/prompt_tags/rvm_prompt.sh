__rvm_prompt_tag () {
  local RVM_PROMPT=""

  if [[ -s ~/.rvm/bin/rvm-prompt ]] ; then
    RVM_PROMPT="${LIGHT_GREEN}\$(~/.rvm/bin/rvm-prompt i v g)${RESET}"
  fi

  echo "${RVM_PROMPT}"
}
