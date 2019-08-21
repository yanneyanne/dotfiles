# dotfiles

My plug-and-play, minimal setup dotfiles. All configurations are made with the following points in mind:

- Installing and configuring should be _fully handled_ by the install script. No manual configuration or preference-wrangling in GUIs should be necessary.
- Configurations should be minimal. This means that plugins should be installed with care, and behavior should adhere as closely as possible to default configurations. Exceptions are reserved for ...
  - Adaptations for Swedish keyboards: Many standard zsh and vim keybindings make more sense on an American keyboard. Changes to ease the experience of using a Swedish keyboard are therefore sometimes necessary.
  - Adaptations which promote a more uniform experience between software: For instance, since vim movement keys are commonly bound to HJKL, moving between tmux panes has been remapped to \<Leader\> + HJKL.


# Installation

Clone these dotfiles and place them in the home directory. The alacritty terminal emulator, Homebrew, zsh, tmux and neovim (among others) will be installed by running the install script. After the installation script has finished, simply start alacritty and the development environment will be correctly configured.

These configurations are primarily geared towards MacOS and certain functionality will fail on a Linux system. This will be addressed in the future.


# Behavior

This section functions both as a description of the more important non-standard configurations as well as a handbook for useful default functionality. Default behaviors are clearly indicated as such.

## (neo)vim

Vim provides a very nice way of editing text (this is why the configurations for software like zsh and tmux attempt to replicate vim behavior - but more on that later...). What follows are a list of editing behaviors (both default and non-default) as well as a rundown of plugins.

### Movement

### Editing

### Plugins

## zsh

### vi-mode

### git prompt

### Searching With fzf and ag

## tmux

### Movement

### Useful tmux Commands

