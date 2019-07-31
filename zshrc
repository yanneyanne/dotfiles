# Load zsh them
source $HOME/dotfiles/themes/shell-theme.zsh

# Load sane VISUAL mode for zsh vi mode
source $HOME/dotfiles/zsh/zsh-vimode-visual.zsh

# Base16 Shell
BASE16_SHELL="$HOME/dotfiles/zsh/oceanic-next.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

############################################
# Vi-mode related commands
############################################
# Vi-key mode
bindkey -v

# Rebinds entering vi-mode to Ctrl-c and interrupt to ^P
bindkey '^c' vi-cmd-mode
stty intr '^P'

# Vi-like history search
bindkey -M vicmd '/' vi-history-search-backward

# Bind beginning/end of line movements to , and - in vim mode
# This mimics the behaviour in vim
bindkey -M vicmd ',' beginning-of-line
bindkey -M vicmd '\-' end-of-line
bindkey -M vivis ','  vi-visual-bol
bindkey -M vivis '\-' vi-visual-eol

# Bind 'kill word' (delete the currently written work) with Ctr-w
bindkey '^w' backward-kill-word

# Allow backspace to work like normal
bindkey '^?' backward-delete-char

# Change default editor to nvim
export EDITOR='nvim'

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

# Do not wait for multi-char sequence commands
export KEYTIMEOUT=1

########################################
# General zsh settings
########################################

# Allow reversed autocompletion cycling with shift-tab
bindkey '^[[Z' reverse-menu-complete

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
 
alias tree='tree -N'

# Alias for nvim 
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Set infinite shell history
HISTFILE='$HOME/.zsh_history'
HISTSIZE=10000000
SAVEHIST=10000000
