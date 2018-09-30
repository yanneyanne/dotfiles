# Load zsh them
source $HOME/dotfiles/themes/shell-theme.zsh

# Vi-key mode
bindkey -v

# Rebinds vi-mode to ^C and interrupt to ^P
bindkey "^c" vi-cmd-mode
stty intr "^P"

# History search
bindkey -M vicmd "/" history-incremental-search-backward

# Bind beginning/end of line movements to , and - in vim mode
# This mimics the behaviour in vim
bindkey -M vicmd "," beginning-of-line
bindkey -M vicmd "\-" end-of-line

# Allow reversed autocompletion cycling with shift-tab
bindkey '^[[Z' reverse-menu-complete

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Format history output to include dates and times
HIST_STAMPS="dd.mm.yyyy"

# Change default editor to nvim
export EDITOR='nvim'

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
