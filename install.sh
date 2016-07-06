#!/bin/bash
##########################
# this install script creates symlinks from the home directory to the dotfiles in ~/dotfiles
##########################

dir=~/.dotfiles
olddir=~/dotfiles_backup		#old dotfiles backup 
files="vimrc vim zshrc tmux.conf tmux.reset.conf"

# Create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in home directory... "
mkdir -p $olddir
echo "Done"

# Change to dotfiles directory
echo -n "Changing to the $dir directory... "
echo "Done"

# Move any existing dotfiles to the backup directory, then creates symlinks to new files in home directory
for file in $files; do
	echo "Moving existing dotfile $file from ~ to $olddir."
	mv ~/.$file $olddir
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done
