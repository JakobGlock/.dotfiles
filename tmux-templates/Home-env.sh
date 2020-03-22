#!/bin/bash

# Cheatsheet Window
cd ~/dev/cheatsheets/
tmux rename-window 'CheatSheet'
tmux send-keys 'vim ~/dev/cheatsheets/commands.md' C-m

# Development Window
cd ~/dev/
tmux new-window
tmux rename-window "Development"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20

# Other Windows
cd ~
tmux new-window
tmux rename-window 'ssh'

cd ~
tmux new-window
tmux rename-window 'ssh'
