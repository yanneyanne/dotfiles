# This theme is heavily inspired (basically copied)
# from martinrotter/powerless

# Set options and settings.
setopt PROMPT_SUBST
setopt PROMPT_SP

color_text="black"
color_user_host="green"
color_code_wrong="red"
color_pwd="blue"
color_git_ok="green"
color_git_dirty="yellow"
color_venv="blue"

# Specify common variables.
rc='%{%f%k%}'

get-user-host() {
  [[ -n "$SSH_CLIENT" ]] && echo -n "%{%F{$1}%K{$2}%} %n@%M $rc"
}

get-pwd() {
  echo -n "%{%F{$1}%K{$2}%} %~ $rc"
}

get-git-info() { 
  local git_branch=$(git symbolic-ref --short HEAD 2> /dev/null)
   
  if [[ -n "$git_branch" ]]; then
    git diff --quiet --ignore-submodules --exit-code HEAD > /dev/null 2>&1
    
    if [[ "$?" != "0" ]]; then
      git_symbols="\u00b1 "
      back_color=$3
    else
      back_color=$2
    fi
  
    echo -n "%{%F{$1}%K{$back_color}%} $git_branch $git_symbols$rc "
  else
    echo " "
  fi
}

get-last-code() {
  [[ (-n "$last_code") && ($last_code -ne 0) ]] && echo -n "%{%F{$1}%K{$2}%} \u2715 "
}

get-venv-info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo -n "%{%F{$1}%K{$2}%} $(basename $VIRTUAL_ENV) $rc"
    fi
}

powerless-prompt() {
  get-user-host $color_text $color_user_host
  get-last-code $color_text $color_code_wrong
  get-pwd $color_text $color_pwd
  get-git-info $color_text $color_git_ok $color_git_dirty
  get-venv-info $color_text $color_venv
}

precmd-powerless() {
  last_code=$?
}

# Attach the hook functions.
[[ ${precmd_functions[(r)precmd-powerless]} != "precmd-powerless" ]] && precmd_functions+=(precmd-powerless)

# Set the prompts.
PROMPT='$(powerless-prompt)'
