#!/bin/bash

# Cheatsheet Window
cd ~/dev/cheatsheets/
tmux rename-window 'CheatSheet'
tmux send-keys 'vim ~/dev/cheatsheets/sysadmin.md' C-m

# Platform Repository
cd ~/dev/platform/
tmux new-window
tmux rename-window 'Platform'
tmux send-keys 'vim' C-m
tmux split-window -v -p 10

# Env Repository
cd ~/dev/env/
tmux new-window
tmux rename-window "Env"
tmux send-keys 'vim' C-m
tmux split-window -v -p 10

# Kubespray Repository
cd ~/dev/kubespray/
tmux new-window
tmux rename-window "Kubespray"
tmux send-keys 'vim' C-m
tmux split-window -v -p 10

# Other Window
cd ~
tmux new-window
tmux rename-window 'ssh'
