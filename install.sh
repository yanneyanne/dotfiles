#!/bin/bash
##########################
# This install script:
# * makes sure that zsh, tmux and neovim are installed correctly
# * creates symlinks from the home directory to the dotfiles in ~/dotfiles
##########################

##########################
# Install dependencies
##########################

if [ -z $(which zsh) ]; then
	echo "zsh not found. Installing zsh..."
	brew install zsh
	echo "Making zsh default shell"
	chsh -s $(which zsh)
fi

if [ -z $(which nvim) ]; then
	echo "neovim not found. Installing neovim..."
	brew install neovim
	echo "Installing python3 and python-for-neovim"
	brew install python3
	pip2 install neovim --upgrade
	pip3 install neovim --upgrade
	echo "Installing neovim plugins"
	vim +'PlugInstall --sync' +qa
fi

if [ -z $(which tmux) ]; then
	echo "tmux not found. Installing tmux..."
	brew install tmux
fi

if [ -z $(which fzf) ]; then
	echo "fzf not found. Installing fzf..."
	brew install fzf
fi

if [ -z $(which ag) ]; then
	echo "ag not found. Installing ag..."
	brew install the_silver_searcher
fi


##########################
# Create symlinks for dotfiles
##########################

dir=~/dotfiles
olddir=~/dotfiles_backup		#old dotfiles backup 
file_paths="vim zsh/zshrc tmux/tmux.conf tmux/tmux.reset.conf"

# Create dotfiles_old in homedir
if [ ! -d "$olddir" ]; then
	echo -n "Creating $olddir for backup of any existing dotfiles in home directory... "
	mkdir -p $olddir
	echo "Done"
fi

# Change to dotfiles directory
echo -n "Changing to the $dir directory... "
echo "Done"

# Move any existing dotfiles to the backup directory, then creates symlinks to new files in home directory
for path in $file_paths; do
	file=$(basename $path)
	if [ -e "$file" ]; then
		echo "Moving existing dotfile $file from ~ to $olddir."
		mv ~/.$file $olddir
	fi
	echo "Creating symlink to $path in home directory."
	ln -sfn "$dir/$path" ~/.$file
done
