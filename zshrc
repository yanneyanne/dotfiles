# Load zsh them
source $HOME/dotfiles/themes/shell-theme.zsh

############################################
# Vi-mode related commands
############################################
# Vi-key mode
bindkey -v

# Rebinds entering vi-mode to Ctrl-c and interrupt to ^P
bindkey "^c" vi-cmd-mode
stty intr "^P"

# Re-entering NORMAL mode after visual mode remapped to Ctrl-c
bindkey -M visual "^c" visual-mode

# Vi-like history search
bindkey -M vicmd "/" vi-history-search-backward

# Bind beginning/end of line movements to , and - in vim mode
# This mimics the behaviour in vim
bindkey -M vicmd "," beginning-of-line
bindkey -M vicmd "\-" end-of-line

# Bind "kill word" (delete the currently written work) with Ctr-w
bindkey '^w' backward-kill-word

# Allow backspace to work like normal
bindkey '^?' backward-delete-char

# Change default editor to nvim
export EDITOR='nvim'

# Catches window resizing event (TRAP WINdow CHange)
# Ensures that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle -R; zle reset-prompt }
}

# Displays a vi mode indicator when in NORMAL mode
function zle-line-init zle-keymap-select {
    case $KEYMAP in
      viins|main) RPS1="" ;;
      vicmd) RPS1="[% NORMAL]%" ;;
    esac
    zle reset-prompt
}

zle -N zle-line-init
# Create new keymap called zle-keymap-select
# Calling this widget makes sure that the prompt is redrawn
# upon switching modes
zle -N zle-keymap-select
export KEYTIMEOUT=1

########################################

# Allow reversed autocompletion cycling with shift-tab
bindkey '^[[Z' reverse-menu-complete

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Format history output to include dates and times
HIST_STAMPS="dd.mm.yyyy"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
 
alias tree='tree -N'

# Alias for nvim 
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Set infinite shell history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
