#!/bin/bash

# Clear Current Windows
tmux kill-window -a

# Cheatsheet Window
cd ~/dev/tools/cheatsheets/
tmux rename-window 'CheatSheet'
tmux send-keys 'vim ~/dev/tools/cheatsheets/sysadmin.md' C-m
tmux split-window -v -p 20

# Platform Repository
cd ~/dev/platform/
tmux new-window
tmux rename-window 'Platform'
tmux send-keys 'vim' C-m
tmux split-window -v -p 20

# Env Repository
cd ~/dev/env/
tmux new-window
tmux rename-window "Env"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20

# Kubespray Repository
cd ~/dev/kubespray/
tmux new-window
tmux rename-window "Kubespray"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20

# Other Windows
cd ~
tmux new-window
tmux rename-window 'ssh'
