#!/bin/bash

# Usage
# -----------------------------------------------------------------------------
# ./multi-panes.sh <num_panes> <sync: (on|off)>

tmux new-window
tmux rename-window 'Multi'

for ((i=1; i<$1; i++));
do
	tmux split-window -h
	tmux select-layout tiled
done

tmux setw synchronize-panes "$2"
