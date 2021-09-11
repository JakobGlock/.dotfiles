#!/bin/bash

# Clear Current Windows
tmux kill-window -a

# Vimwiki
tmux new-window -c ~/vimwiki
tmux rename-window 'Vimwiki'
tmux send-keys 'vim index.wiki' C-m

# General Windows
tmux new-window -c ~/
tmux send-keys 'cd dev && tmux move-window -r && clear' C-m
tmux rename-window 'Term1'

tmux new-window -c ~/
tmux send-keys 'cd dev && tmux move-window -r && clear' C-m
tmux rename-window 'Term2'
