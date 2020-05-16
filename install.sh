#!/bin/bash

GITCONFIG=~/.gitconfig
GNOME_SETTINGS=/tmp/saved_settings.dconf
VUNDLE_DIR=~/.vim/bundle/

echo "INFO: Installing dotfiles and basic software"
echo ""

# Gather info
read -r -s -p "INFO: What is your sudo password? " spw
echo ""
read -r -p "INFO: Is this a workstation or server (w|W|s|S) " mt
read -r -p "INFO: Would you like to run the Ansible provisioner? (y|Y|n|N) " ap
read -r -p "INFO: Restore Gnome settings from dconf file? (y|Y|n|N) " gnome

if [ "$ap" = "y" ] || [ "$ap" = "Y" ]
then
	if [ ! -f "$GITCONFIG" ]
	then
		read -r -p "INFO: What is your Github username? " github_username
		read -r -p "INFO: What is your Github email address? " github_email
	fi
fi

if [ "$gnome" = "y" ] || [ "$gnome" = "Y" ]
then
	if [ -f "$GNOME_SETTINGS" ]
	then
		dconf load / < /tmp/saved_settings.dconf
	else
		echo "ERROR: $GNOME_SETTINGS does not exist"
		echo "INFO: This is your gnome settings, I have mine on github in a private repo"
		echo "INFO: You can get it by running this command: dconf load / < saved_settings.dconf"
		exit 0
	fi
fi

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
	echo "$spw" | sudo -S apt install -y ansible aptitude
	echo ""
	

	if [ "$ap" = "y" ] || [ "$ap" = "Y" ]
	then
		read -r -p "Have you created a terminal profile called 'gruvbox-dark'? (y|Y|n|N) " gruvbox

		if [ ! "$gruvbox" = "y" ] && [ ! "$gruvbox" = "Y" ]
		then
			echo "ERROR: Create a terminal profile called 'gruvbox-dark' before proceeding"
			exit 0
		fi

		if [ ! -f "$GITCONFIG" ]
		then
			# Set git-config values
			echo "INFO: Seting git-config username and email"
			git config --global user.name "$github_username"
			git config --global user.email "$github_email"
			echo ""
		fi

		echo "INFO: Running Ansible playbook"
		ansible-playbook provision/setup.yml -b --extra-vars "ansible_become_pass='${spw}'"
	else
		echo ""
		echo "INFO: Skipping Ansible provisioning"
		echo ""
	fi
else
	# Install on server
	echo "INFO: Installing symlinks for dotfiles"
	ln -sf ~/.dotfiles/.vimrc ~/.vimrc
	ln -sf ~/.dotfiles/.bash_aliases ~/.bash_aliases
	echo ""
fi

# Install Vundle plugin for Vim
if [ ! -d "$VUNDLE_DIR" ]; then
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

if [ -x "$(command -v neofetch)" ]; 
then
	neofetch
	echo ""
else
	echo "INFO: neofetch not installed, skipping";
fi

echo "INFO: Finished!"
