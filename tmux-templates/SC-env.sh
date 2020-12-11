#!/bin/bash

# Supercollider Window
cd ~/dev/
tmux rename-window "Supercollider"
tmux send-keys 'cd $HOME/dev/supercollider && vim' C-m
tmux split-window -v -p 20
tmux send-keys 'SCBoot' C-m

# Other Windows
cd ~
tmux new-window
tmux rename-window 'other'

tmux select-window -t 1
