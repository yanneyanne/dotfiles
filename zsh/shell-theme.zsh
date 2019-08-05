# This theme is heavily inspired 
# from martinrotter/powerless

# Load sane VISUAL mode for zsh vi mode
source $HOME/dotfiles/zsh/zsh-vimode-visual.zsh

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

# Define a reset color string
rc='%{%f%k%}'

get-user-host() {
  [[ -n "$SSH_CLIENT" ]] && echo -n "%{%F{$1}%K{$2}%} %n@%M $rc"
}

get-pwd() {
  echo -n "%{%F{$1}%K{$2}%} %~ $rc"
}


get-last-code() {
  [[ (-n "$last_code") && ($last_code -ne 0) ]] && echo -n "%{%F{$1}%K{$2}%} \u2715 "
}

get-venv-info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo -n "%{%F{$1}%K{$2}%} $(basename $VIRTUAL_ENV) $rc"
    fi
}

############################################
# Git prompt information
############################################

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
############################################
# Vi mode normal/visual mode indicators
############################################

# Catches window resizing event (TRAP WINdow CHange)
# Ensures that the prompt is redrawn when the terminal size changes.
function TRAPWINCH() {
  zle && { zle -R; zle reset-prompt }
}

# Set initial vi mode indicator, if it wasn't already defined by a theme
if RPS1=='' && RPROMPT==''; then
  RPS1=''
fi

# Load colorsscheme module
autoload -U colors && colors
# Activate prompt escape sequence substitution
setopt promptsubst
# Displays a vi mode indicator when in NORMAL or VISUAL mode
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    viins|main) RPS1='' ;; # If KEYMAP set to INSERT mode, display nothing
    vicmd) RPS1='%{$fg[blue]%}% [NORMAL]% %{$reset_color%}' ;;
    vivis) RPS1=$'%{\e[38;5;16m%}% [VISUAL]% %{$reset_color%}'
  esac
  zle reset-prompt
}

# Create two new keymaps: zle-line-init, zle-keymap-select
# Calling this widget makes sure that the prompt is redrawn
# upon switching modes
zle -N zle-line-init
zle -N zle-keymap-select

# Augment original accept-line (triggered on Enter) with also
# removing the vi mode NORMAL and VISUAL indicator
function accept-line-and-remove-mode-indicator() {
  RPS1=''
  zle reset-prompt
  zle accept-line
}

# Create a widget from `accept-line-and-remove-mode-indicator' with the same name
zle -N accept-line-and-remove-mode-indicator

# Rebind Enter in vim NORMAL and VISUAL modes
bindkey -M vicmd '^M' accept-line-and-remove-mode-indicator
bindkey -M vivis '^M' accept-line-and-remove-mode-indicator

############################################
# Final call of prompt
############################################

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

