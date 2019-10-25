#!/bin/bash

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
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.env ~/.env
ln -sf ~/.dotfiles/.bash_aliases ~/.bash_aliases

echo "Finished!"
