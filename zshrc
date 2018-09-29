# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="agnoster"

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

# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

# Change default editor to nvim
export EDITOR='nvim'

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
 
alias tree='tree -N'
# Uncomment this line to hide the default user in the prompt
DEFAULT_USER=`whoami`

# Alias for nvim 
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Set infinite shell history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
