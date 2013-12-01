source ~/.bash/lib/bash_colors.sh
source ~/.bash/lib/prompt_tags/rvm_prompt.sh
source ~/.bash/lib/prompt_tags/git_prompt.sh

__prompt_tags () {
  local PROMPT_TAGS=""
  local RVM_PROMPT=$(__rvm_prompt_tag)
  local GIT_PROMPT=$(__git_prompt_tag)

  if [[ $RVM_PROMPT ]] ; then
    PROMPT_TAGS="${PROMPT_TAGS}${RVM_PROMPT}${RESET} "
  fi

  if [[ $GIT_PROMPT ]] ; then
    PROMPT_TAGS="${PROMPT_TAGS}${GIT_PROMPT}${RESET} "
  fi

  if [[ $PROMPT_TAGS ]] ; then
    PROMPT_TAGS="${BLACK}§ ${RESET}${PROMPT_TAGS}${RESET}"
  fi

  echo "${PROMPT_TAGS}"
}

__prompt_info () {
  history -a
  history -c
  history -r

  local STATUS_COLOR=${RED}

  # Change according to the command last status code
  if [ $? -eq 0 ]; then
    STATUS_COLOR=${GREEN}
  fi

  PS1="\w $(__prompt_tags)\n${STATUS_COLOR}\$ ${RESET}"
}

PROMPT_COMMAND=__prompt_info
