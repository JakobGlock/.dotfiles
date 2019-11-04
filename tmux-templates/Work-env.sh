#!/bin/bash

cd ~/dev/cheatsheets/
tmux rename-window 'CheatSheet'
tmux send-keys 'vim sysadmin.md' C-m

cd ~/dev/platform/
tmux new-window
tmux rename-window 'Platform'
tmux send-keys 'vim' C-m
tmux split-window -v -p 10

cd ~/dev/env/
tmux new-window
tmux rename-window "Env"
tmux send-keys 'vim' C-m
tmux split-window -v -p 10

cd ~
tmux new-window
tmux rename-window 'ssh'
