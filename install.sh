#!/bin/bash

read -p "INFO: Is this a workstation or server (w|W|s|S)" mt

if [ ! "$mt" = "w" ] || [ ! "$mt" = "W" ] || [ ! "$mt" = "s" ] || [ ! "$mt" = "S" ]
then
	echo "ERROR: Choose a valid option, w|W for a workstation or s|S for a server"
	exit 0
fi

# Install Vundle plugin for Vim
if [ ! -d ~/.vim/bundle/ ]; then
	echo "Installing Vundle plugin for Vim"
	echo ""
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
	echo "Vundle already installed, skipping"
	echo ""
fi

# Create symlinks
echo "Installing symlinks...."

if [ "$mt" = "w" ] || [ "$mt" = "W" ]
then
	# Install on workstation
	ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
	ln -sf ~/.dotfiles/.vimrc ~/.vimrc
	ln -sf ~/.dotfiles/.env ~/.env
	ln -sf ~/.dotfiles/.bash_aliases ~/.bash_aliases
else
	# Install on server
	ln -sf ~/.dotfiles/.vimrc ~/.vimrc
	ln -sf ~/.dotfiles/.bash_aliases ~/.bash_aliases
fi

# Install Vim plugins
vim +PluginInstall +qall

echo "Finished!"
