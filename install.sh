#!/bin/bash
##########################
# this install script creates symlinks from the home directory to the dotfiles in ~/dotfiles
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
