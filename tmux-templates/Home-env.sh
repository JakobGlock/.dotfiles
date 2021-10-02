#!/bin/bash

# Clear Current Windows
tmux kill-window -a

# Vimwiki
tmux new-window -c ~/vimwiki
tmux rename-window 'Vimwiki'
tmux send-keys 'vim index.wiki' C-m

# Music
tmux new-window -c ~/Music
tmux rename-window 'Music'
tmux send-keys 'moc' C-m

# General Windows
tmux new-window -c ~/
tmux send-keys 'cd && tmux move-window -r && clear' C-m
tmux rename-window 'Term1'

tmux new-window -c ~/
tmux send-keys 'cd && tmux move-window -r && clear' C-m
tmux rename-window 'Term2'
