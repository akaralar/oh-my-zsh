function prompt_char {
    #git branch >/dev/null 2>/dev/null && echo '±' && return
    #hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

# function battery_charge {
#     echo `~/.bin/batcharge.swift` 2>/dev/null
# }

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# function user_name {
# 	%n
# }

# function machine_name {
# 	%M
# }

GIT_DIRTY_COLOR=$FG[133]
GIT_CLEAN_COLOR=$FG[118]
GIT_PROMPT_INFO=$FG[012]
PROMPT_PROMPT=$FG[077]
VENV_COLOR=$fg[yellow]

# use these colors for the first 2 if iterm-colors is not installed
# PROMPT_USER_COLOR=$FG[160]
# PROMPT_MACHINE_COLOR=$FG[208]

# use these colors if iterm-colors is installed
PROMPT_USER_COLOR=$fg[magenta]
PROMPT_MACHINE_COLOR=$fg[yellow]


function prompt_exit_status() {
  if [ $? -eq 0 ]; then
    echo "%{$fg_bold[green]%}❯%{$reset_color%}" #❯
  else
    echo "%{$GIT_DIRTY_COLOR%}❯%{$reset_color%}" #❯
  fi
}

function prompt_directory() {
  echo "%{$PROMPT_MACHINE_COLOR%}%c%{$reset_color%}"
  #%{$fg_bold[green]%}${PWD/#$HOME/~}
}

# function hg_prompt_info {
#     hg prompt --angle-brackets "\
# < on %{$fg[magenta]%}<branch>%{$reset_color%}>\
# < at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
# %{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
# patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
# }


PROMPT=' %{$VENV_COLOR%}$(virtualenv_info)$(prompt_directory)%{$reset_color%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}$(prompt_exit_status) '

#add following to prompt for current user and machine
# %{$PROMPT_USER_COLOR%}%n%{$reset_color%} at %{$PROMPT_MACHINE_COLOR%}%M%{$reset_color%} in 

# PROMPT='%{$VENV_COLOR%}$(virtualenv_info)%{$PROMPT_USER_COLOR%}$(user_name)%{$reset_color%} at %{$PROMPT_MACHINE_COLOR%}$(machine_name)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} $(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status)$(hg_prompt_info)
# %{$reset_color%}$(prompt_char) %{$PROMPT_PROMPT%}❯%{$reset_color%} '


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
