#!/bin/bash

# Clear Current Windows
tmux kill-window -a

# Vimwiki Window
tmux new-window -c ~/vimwiki
tmux rename-window 'VimWiki'
tmux send-keys 'vim index.wiki' C-m
tmux split-window -v -p 20 -c ~/vimwiki

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

# Terraform Repository
tmux new-window -c ~/dev/terraform
tmux rename-window "Terraform"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/terraform

# Terraform-modules Repository
tmux new-window -c ~/dev/terraform-modules
tmux rename-window "Terraform-modules"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/terraform-modules

# Other Windows
tmux new-window -c ~/dev
tmux send-keys 'tmux move-window -r && clear' C-m
tmux rename-window 'ssh'

