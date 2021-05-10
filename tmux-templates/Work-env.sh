#!/bin/bash

# Clear Current Windows
tmux kill-window -a

# Cheatsheet Window
tmux new-window -c ~/dev/tools/cheatsheets
tmux rename-window 'CheatSheet'
tmux send-keys 'vim sysadmin.md' C-m
tmux split-window -v -p 20 -c ~/dev/tools/cheatsheets

# Platform Repository
tmux new-window -c ~/dev/platform
tmux rename-window 'Platform'
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/platform

# Env Repository
tmux new-window -c ~/dev/env
tmux rename-window "Env"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/env

# Kubespray Repository
tmux new-window -c ~/dev/kubespray
tmux rename-window "Kubespray"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/kubespray

# Other Windows
tmux new-window -c ~/dev
tmux send-keys 'tmux move-window -r && clear' C-m
tmux rename-window 'ssh'

