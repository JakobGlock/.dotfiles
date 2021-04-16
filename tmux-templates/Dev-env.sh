#!/bin/bash

# Clear Current Windows
tmux kill-window -a

tmux rename-window 'Development'
tmux send-keys 'cd ~/dev && vim' C-m
tmux split-window -v -p 10
tmux send-keys 'cd ~/dev && clear' C-m

tmux new-window
tmux rename-window 'Shell'
