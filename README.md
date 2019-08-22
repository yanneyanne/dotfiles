# dotfiles

My plug-and-play, minimal setup dotfiles. All configurations are made with the following points in mind:

- Installing and configuring should be _fully handled_ by the install script. No manual configuration or preference-wrangling in GUIs should be necessary.
- Configurations should be minimal. This means that plugins should be installed with care, and behavior should adhere as closely as possible to default configurations. Exceptions are reserved for ...
  - Adaptations for Swedish keyboards: Many standard zsh and vim keybindings make more sense on an American keyboard. Changes to ease the experience of using a Swedish keyboard are therefore sometimes necessary.
  - Adaptations which promote a more uniform experience between software: For instance, since vim movement keys are commonly bound to <kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd>, moving between tmux panes has been remapped to <kbd>\<Leader\> + hjkl</kbd>.


# Installation

Clone these dotfiles and place them in the home directory. The alacritty terminal emulator, Homebrew, zsh, tmux and neovim (among others) will be installed by running the install script. After the installation script has finished, simply start alacritty and the development environment will be correctly configured.

These configurations are primarily geared towards MacOS and certain functionality will fail on a Linux system. This will be addressed in the future.


# Behavior

This section functions both as a description of the more important non-standard configurations as well as a handbook for useful default functionality. Default behaviors are clearly indicated as such.

## (neo)vim

Vim provides a very nice way of editing text (this is why the configurations for software like zsh and tmux attempt to replicate vim behavior - but more on that later...). What follows are a list of editing behaviors (both default and non-default) as well as a rundown of plugins.

### Movement

<kbd>Ctrl-C</kbd> - enter NORMAL mode.

<kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd> - move the cursor one step left/up/down/right. (_Default_)

<kbd>H</kbd> <kbd>M</kbd> <kbd>L</kbd> - move the cursor to the top (_high_), middle or bottom (_low_) of the window, respectively. (_Default_)

<kbd>,</kbd> <kbd>-</kbd> - move cursor to the beginning/end of a line.

<kbd>/<STRING> </kbd> <kbd>?<STRING></kbd> - search forwards/backwards for \<STRING\> (_Default_).

<kbd>*</kbd> - search for the word that is currently under the cursor (_Default_).

<kbd>t</kbd> <kbd>T</kbd> - move the cursor forward/backward up un**t**il a character (_Default_).

<kbd>f</kbd> <kbd>F</kbd> - move the cursor forward/backward to **f**ind a character (_Default_).

<kbd>n</kbd> <kbd>N</kbd>  - jump to the next/previous search result.

### Editing
Editing in vim is very logically constructed. Complex actions can be efficiently communicated in the following format,

> \<verb\> \<modifier\> \<noun\>

For instance, observe the following command,

<kbd>di"</kbd> - **d**elete the text **i**nside the quotations.

This command clearly demonstrates the structure of a basic command, where the verb <kbd>d</kbd> dictates what action should be performed and the modifier and nouns <kbd>i</kbd> and <kbd>"</kbd> describes which part of the text should be affected by the aforementioned verb. The below tables display a more complete list of verbs, modifiers and nouns.

| verb |                                                                                |
|  -   |:------------------------------------------------------------------------------:|
|  d   | delete and save deletion to default register (essentially a _cut_) (_Default_) |
|  c   | change - delete and enter insert mode                              (_Default_) |
|  y   | yank/copy text                                                     (_Default_) |
|  x   | delete without cutting                                                         |

| modifier   |                                                                                |
|  -         |:------------------------------------------------------------------------------:|
|  i         | delete and save deletion to default register (essentially a _cut_) (_Default_) |
|  a         | change - delete and enter insert mode                              (_Default_) |
|  \<NUM\>     | repeat the verb for <NUM> <nouns>                                  (_Default_) |
|  t         | un**t**il (but before) some sought-after character                 (_Default_) |
|  f         | **f**ind (and include) some sought-after character                 (_Default_) |
|  /\<STRING\> | search for some string                                             (_Default_) |
|  ?\<STRING\> | search backwards for some string                                   (_Default_) |

| noun |                                                                                |
|  -   |:------------------------------------------------------------------------------:|
|  w   | **w**ord                                                           (_Default_) |
|  s   | **s**entence                                                       (_Default_) |
|  p   | **p**aragraph                                                      (_Default_) |
|  b   | code **b**lock                                                     (_Default_) |

An alternate command format is the following,

> \<verb\> \<movement>

For instance, observe the following command,

<kbd>d3w</kbd> - **d**elete the next **3** **w**ords.

Note that the yank and put registers in vim have been equated with the system clipboard. This means, for example, that is possible to copy text from an internet browser and put this directly in vim with <kbd>p</kbd> in normal mode. Text can also be yanked in vim and pasted anywhere with <kbd>Cmd-V</kbd>.

### Plugins

### Searching With fzf and ag

## zsh

### vi-mode

### git prompt

## tmux

### Movement

### Useful tmux Commands
