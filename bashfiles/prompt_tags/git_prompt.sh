# Git prompt
# Show branch and dirty status
#
# Based on Geoffrey Grosenbach's
#   https://github.com/topfunky/zsh-simple/blob/master/bin/git-cwd-info

__git_prompt_tag () {
  GIT_REPO_PATH=`git rev-parse --git-dir 2>/dev/null`
  GIT_PROMPT=""

  if [[ $GIT_REPO_PATH != '' && $GIT_REPO_PATH != '~' && $GIT_REPO_PATH != "$HOME/.git" ]]; then

    GIT_BRANCH=`git symbolic-ref -q HEAD | sed 's/refs\/heads\///'`
    GIT_COMMIT_ID=`git rev-parse --short HEAD 2>/dev/null`

    GIT_MODE=""
    if [[ -e "$GIT_REPO_PATH/BISECT_LOG" ]]; then
      GIT_MODE=" +bisect"
    elif [[ -e "$GIT_REPO_PATH/MERGE_HEAD" ]]; then
      GIT_MODE=" +merge"
    elif [[ -e "$GIT_REPO_PATH/rebase" || -e "$GIT_REPO_PATH/rebase-apply" || -e "$GIT_REPO_PATH/rebase-merge" || -e "$GIT_REPO_PATH/../.dotest" ]]; then
      GIT_MODE=" +rebase"
    fi

    GIT_DIRTY=""
    if [[ "$GIT_REPO_PATH" != '.' && `git ls-files -dom` != "" ]]; then
      GIT_DIRTY=" ${BROWN}⚠${RESET}"
    fi

    GIT_PROMPT="${LIGHT_GREEN}$GIT_BRANCH ${BLACK}$GIT_COMMIT_ID${RESET}$GIT_MODE$GIT_DIRTY"
  fi

  echo "$GIT_PROMPT"
}
