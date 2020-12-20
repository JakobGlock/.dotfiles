#!/bin/bash

# Supercollider Window
cd ~/dev/
tmux rename-window "Supercollider"
tmux send-keys 'cd $HOME/dev/supercollider && vim' C-m
tmux split-window -v -p 20
tmux send-keys 'SCBoot' C-m

# Jackd Window
cd ~
tmux new-window
tmux rename-window 'Jackd'
tmux send-keys 'jackd -R -d alsa -r 44100 -p 2048 -S --device "hw:Generic,0"' C-m

# Other Window
cd ~
tmux new-window
tmux rename-window 'Other'

tmux select-window -t 1
