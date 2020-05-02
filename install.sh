#!/bin/bash

echo "INFO: Installing dotfiles and basic software"
echo ""

# Gather info
read -r -s -p "INFO: What is your sudo password? " spw
echo ""
read -r -p "INFO: Is this a workstation or server (w|W|s|S) " mt

if [ ! "$mt" = "w" ] && [ ! "$mt" = "W" ] && [ ! "$mt" = "s" ] && [ ! "$mt" = "S" ]
then
	echo "ERROR: Choose a valid option, w|W for a workstation or s|S for a server"
	exit 0
fi


# Create symlinks, install basic software
if [ "$mt" = "w" ] || [ "$mt" = "W" ]
then
	# Install on workstation
	echo "INFO: Installing symlinks for dotfiles"
	echo ""
	ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
	ln -sf ~/.dotfiles/.vimrc ~/.vimrc
	ln -sf ~/.dotfiles/.env ~/.env
	ln -sf ~/.dotfiles/.bash_aliases ~/.bash_aliases
	
	echo "INFO: Installing software"
	echo "$spw" | sudo apt install -y ansible shellcheck ncdu mc htop traceroute vim tmux ffmpeg
	echo ""
else
	# Install on server
	echo "INFO: Installing symlinks for dotfiles"
	ln -sf ~/.dotfiles/.vimrc ~/.vimrc
	ln -sf ~/.dotfiles/.bash_aliases ~/.bash_aliases
	echo ""
fi

# Install Vundle plugin for Vim
if [ ! -d ~/.vim/bundle/ ]; then
	echo "INFO: Installing Vundle plugin for Vim"
	echo ""
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
	echo "ERROR: Vundle already installed, skipping"
	echo ""
fi

# Install Vim plugins
echo "INFO: Installing Vim plugins"
vim +PluginInstall +qall
echo ""

echo "INFO: Finished!"
