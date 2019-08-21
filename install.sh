#!/bin/bash
##########################
# This install script:
# * makes sure that alacritty, zsh, tmux and neovim are installed correctly
# * creates symlinks from the home directory to the dotfiles in ~/dotfiles
##########################

##########################
# Install dependencies
##########################

if [ -f "Applications/Alacritty.app" ]; then
	echo "alacritty not found. Installing alacritty..."
	brew cask install alacritty
fi

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

dir=$(pwd)
backup_dir=~/dotfiles_backup

# Relative paths for the config files to be installed
dotfile_paths=( \
	alacritty/alacritty.yml \
	zsh/zshrc \
	vim \
	tmux/tmux.conf \
	tmux/tmux.reset.conf \
)
# The target locations at which configs are to be installed
install_paths=( \
	~/.config/alacritty/alacritty.yml \
	~/.zshrc \
	~/.config/nvim \
	~/.tmux.conf \
	~/.tmux.reset.conf \
)

# Create dotfiles_old in homedir
if [ ! -d "$backup_dir" ]; then
	echo -n "Creating $backup_dir for backup of any existing dotfiles in home directory... "
	mkdir -p $backup_dir
	echo "Done"
fi

# Link dotfile to its target install path
# Existing dotfiles are moved to the backup directory
install_config () {
	local dotfile_path=$1
	local install_path=$2
	dotfile=$(basename $dotfile_path)
	install_dir=$(dirname $install_path)
	if [ -e "$install_path" ]; then
		echo "Moving existing dotfile $dotfile to $backup_dir."
		mv $install_path $backup_dir
	fi
	echo "Creating symlink to $dotfile at $install_path"
	mkdir -p "$install_dir"
	ln -sfn "$dir/$dotfile_path" "$install_path"
}

for (( i = 0; i < ${#dotfile_paths[@]}; i++))
do
	install_config ${dotfile_paths[i]} ${install_paths[i]}
done
