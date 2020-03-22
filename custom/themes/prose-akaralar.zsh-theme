
GIT_DIRTY_COLOR=$FG[133]
GIT_CLEAN_COLOR=$FG[118]
GIT_PROMPT_INFO=$FG[012]
PROMPT_PROMPT=$FG[077]
VENV_COLOR=$fg[yellow]

# use these colors if iterm-colors is installed
PROMPT_USER_COLOR=$fg[magenta]
PROMPT_MACHINE_COLOR=$fg[yellow]


function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function prompt_exit_status() {
  if [ $? -eq 0 ]; then
    echo "%{$fg_bold[green]%}❯%{$reset_color%}" #❯
  else
    echo "%{$GIT_DIRTY_COLOR%}❯%{$reset_color%}" #❯
  fi
}

function prompt_directory() {
  echo "%{$PROMPT_MACHINE_COLOR%}%c%{$reset_color%}"
}

PROMPT=' %{$VENV_COLOR%}$(virtualenv_info)$(prompt_directory)%{$reset_color%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}$(prompt_exit_status) '
RPROMPT='%{$VENV_COLOR%}$(prompt_directory) %{$reset_color%}%T '

#RPROMPT='%{$VENV_COLOR%}$(virtualenv_info)'
#if you want battery status in the right prompt, append line below
#%{$reset_color%}$(battery_charge)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$GIT_PROMPT_INFO%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$GIT_DIRTY_COLOR%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$GIT_CLEAN_COLOR%}✔"
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[166]%}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%}✭%{$reset_color%}"
