#!/bin/bash
# This script spits out a list of scripts within a folder
# which you can choose to run, by entering a number and 
# pressing enter

clear
echo -e "\nChoose a template:\n"

i=0
search_dir=~/.dotfiles/tmux-templates/*
for filename in $search_dir;
do
	i=$(expr $i + 1)	
	f=$(basename $filename)
	echo -e "\t$i. ""${f%.*}"
done

echo -e "\nPick a template:"

read -s input
clear

i=0
flag=false
for filename in $search_dir;
do
	i=$(expr $i + 1)
	if [ $input -eq $i ]
	then
		flag=true
		$filename && break
	fi
done

if [ $flag == 'false' ]
then
	echo "WARNING: Template does not exist, exiting"
	sleep 2
fi
