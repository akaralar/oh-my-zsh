: ${omg_ungit_prompt:=$PS1}
: ${omg_second_line:="%~ • "}
: ${omg_is_a_git_repo_symbol:=$i_oct_octoface}                      #  i_fa_git 
: ${omg_has_untracked_files_symbol:=$i_fa_file_o}                   #  i_oct_star 
: ${omg_has_adds_symbol:=$i_fa_plus}                                # 
: ${omg_has_deletions_symbol:=$i_fa_minus}                          # 
: ${omg_has_cached_deletions_symbol:=$i_oct_x}                      # 
: ${omg_has_modifications_symbol:=$i_oct_keyboard}                  # 
: ${omg_has_cached_modifications_symbol:=$i_fa_file_code_o}         #  i_oct_file_code 
: ${omg_ready_to_commit_symbol:=$i_oct_git_commit}                  # 
: ${omg_is_on_a_tag_symbol:=$i_oct_tag}                             # 
: ${omg_needs_to_merge_symbol:=$i_oct_repo_forked}                  # 
: ${omg_detached_symbol:=$i_fa_chain_broken}                        # 
: ${omg_can_fast_forward_symbol:=$i_fa_angle_double_up}             # 
: ${omg_has_diverged_symbol:=$i_oct_git_branch}                     # 
: ${omg_not_tracked_branch_symbol:=$i_fa_laptop}                    # 
: ${omg_rebase_tracking_branch_symbol:=$i_oct_git_compare}          # 
: ${omg_merge_tracking_branch_symbol:=$i_oct_git_pull_request}      #  i_oct_git_merge 
: ${omg_should_push_symbol:=$i_oct_cloud_upload}                    #  i_oct_repo_push 
: ${omg_has_stashes_symbol:=$i_oct_inbox}                           # 
: ${omg_has_action_in_progress_symbol:=$i_oct_tools}                #  i_fa_wrench  i_fa_cogs  i_oct_pulse 
: ${omg_wip_symbol:=$i_fa_flask}                                    # 
: ${omg_divider:=$i_pl_left_hard_divider}                           # 

autoload -U colors && colors

PROMPT_PROMPT=$FG[077]
VENV_COLOR=$fg[yellow]

# use these colors if iterm-colors is installed
PROMPT_USER_COLOR=$fg[magenta]


PROMPT='$(build_prompt)'
# RPROMPT='%{$VENV_COLOR%}$(virtualenv_info)$(prompt_directory) %{$reset_color%}%T '

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}


function prompt_exit_status() {
  if [ $? -eq 0 ]; then
    echo "%{$VENV_COLOR%}$(virtualenv_info) %{$fg_bold[green]%}❯%{$reset_color%} " #❯
  else
    echo "%{$VENV_COLOR%}$(virtualenv_info) %{$FG[133]%}❯%{$reset_color%} " #❯
  fi
}

function prompt_directory() {
  echo "%{$PROMPT_MACHINE_COLOR%}%c%{$reset_color%}"
}

function enrich_append {
    local flag=$1
    local symbol=$2
    local color=${3:-$omg_default_color_on}
    if [[ $flag == false ]]; then symbol=' '; fi

    echo -n "${color}${symbol}  "
}

# function work_in_progress {
#   if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
#     echo "WIP!!"
#   fi
# }

function custom_build_prompt {
    local enabled=${1}
    local current_commit_hash=${2}
    local is_a_git_repo=${3}
    local current_branch=$4
    local detached=${5}
    local just_init=${6}
    local has_upstream=${7}
    local has_modifications=${8}
    local has_modifications_cached=${9}
    local has_adds=${10}
    local has_deletions=${11}
    local has_deletions_cached=${12}
    local has_untracked_files=${13}
    local ready_to_commit=${14}
    local tag_at_current_commit=${15}
    local is_on_a_tag=${16}
    local has_upstream=${17}
    local commits_ahead=${18}
    local commits_behind=${19}
    local has_diverged=${20}
    local should_push=${21}
    local will_rebase=${22}
    local has_stashes=${23}
    local action=${24}
    local is_work_in_progress=false
    if [ "$(work_in_progress)" = "WIP!!" ]; then
        is_work_in_progress=true
    fi

    local prompt=""
    local original_prompt=$(prompt_exit_status)

    local red_color_shade=124
    local yellow_color_shade=129
    local white_color_shade=250
    local black_on_white="%K{$white_color_shade}%F{black}"
    local yellow_on_white="%K{$white_color_shade}%F{$yellow_color_shade}"
    local red_on_white="%K{$white_color_shade}%F{$red_color_shade}"
    local red_on_black="%K{black}%F{$red_color_shade}"
    local black_on_red="%K{$red_color_shade}%F{black}"
    local white_on_red="%K{$red_color_shade}%F{$white_color_shade}"
    local yellow_on_red="%K{$red_color_shade}%F{$yellow_color_shade}"

    # Flags
    local omg_default_color_on="${black_on_white}"

    local current_path="%~"

    if [[ $is_a_git_repo == true ]]; then
        # on filesystem
        prompt="${black_on_white} "
        prompt+=$(enrich_append $is_a_git_repo $omg_is_a_git_repo_symbol "${black_on_white}")
        prompt+=$(enrich_append $has_stashes $omg_has_stashes_symbol "${yellow_on_white}")
        prompt+=$(enrich_append $is_work_in_progress $omg_wip_symbol "${yellow_on_white}")

        prompt+=$(enrich_append $has_untracked_files $omg_has_untracked_files_symbol "${red_on_white}")
        prompt+=$(enrich_append $has_modifications $omg_has_modifications_symbol "${red_on_white}")
        prompt+=$(enrich_append $has_deletions $omg_has_deletions_symbol "${red_on_white}")


        # ready
        prompt+=$(enrich_append $has_adds $omg_has_adds_symbol "${black_on_white}")
        prompt+=$(enrich_append $has_modifications_cached $omg_has_cached_modifications_symbol "${black_on_white}")
        prompt+=$(enrich_append $has_deletions_cached $omg_has_cached_deletions_symbol "${black_on_white}")

        # next operation

        prompt+=$(enrich_append $ready_to_commit $omg_ready_to_commit_symbol "${red_on_white}")
        prompt+=$(enrich_append $action "${omg_has_action_in_progress_symbol} $action" "${red_on_white}")

        # where

        prompt="${prompt} ${white_on_red}$omg_divider ${black_on_red}"
        if [[ $detached == true ]]; then
            prompt+=$(enrich_append $detached $omg_detached_symbol "${white_on_red}")
            prompt+=$(enrich_append $detached "(${current_commit_hash:0:7})" "${black_on_red}")
        else
            if [[ $has_upstream == false ]]; then
                prompt+=$(enrich_append true "-- ${omg_not_tracked_branch_symbol}  --  (${current_branch})" "${black_on_red}")
            else
                if [[ $will_rebase == true ]]; then
                    local type_of_upstream=$omg_rebase_tracking_branch_symbol
                else
                    local type_of_upstream=$omg_merge_tracking_branch_symbol
                fi

                if [[ $has_diverged == true ]]; then
                    prompt+=$(enrich_append true "-${commits_behind} ${omg_has_diverged_symbol} +${commits_ahead}" "${white_on_red}")
                else
                    if [[ $commits_behind -gt 0 ]]; then
                        prompt+=$(enrich_append true "-${commits_behind} %F{$white_color_shade}${omg_can_fast_forward_symbol}%F{black} --" "${black_on_red}")
                    fi
                    if [[ $commits_ahead -gt 0 ]]; then
                        prompt+=$(enrich_append true "-- %F{$white_color_shade}${omg_should_push_symbol}%F{black}  +${commits_ahead}" "${black_on_red}")
                    fi
                    if [[ $commits_ahead == 0 && $commits_behind == 0 ]]; then
                         prompt+=$(enrich_append true " --   -- " "${black_on_red}")
                    fi

                fi
                prompt+=$(enrich_append true "(${current_branch} ${type_of_upstream} ${upstream//\/$current_branch/})" "${black_on_red}")
            fi
        fi
        prompt+=$(enrich_append ${is_on_a_tag} "${omg_is_on_a_tag_symbol} ${tag_at_current_commit}" "${black_on_red}")
        prompt+="%k%F{$red_color_shade}$omg_divider%k%f
${original_prompt}"
    else
        prompt="${original_prompt}"
    fi

    echo "${prompt}"
}
