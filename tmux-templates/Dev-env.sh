#!/bin/bash

cd ~/dev
tmux rename-window 'Development'
tmux send-keys 'vim' C-m
tmux split-window -v -p 10

tmux new-window
tmux rename-window 'Shell'
