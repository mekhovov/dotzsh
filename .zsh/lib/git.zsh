parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo " %{$fg_bold[red]%}✗%{$reset_color%}"
}

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ %{$fg_bold[blue]%}(%{$fg_bold[cyan]%}\1$(parse_git_dirty)%{$fg_bold[blue]%})%{$reset_color%}/"
}

git_prompt_info() {
  if [[ -d .git ]]; then
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    branch=${ref#refs/heads/}
    CURRENT_BRANCH="%{$fg[blue]%}(%{$fg[cyan]%}${branch}$(parse_git_dirty)%{$fg[blue]%})%{$reset_color%}"
  else
    CURRENT_BRANCH=''
  fi

  echo $CURRENT_BRANCH
}

