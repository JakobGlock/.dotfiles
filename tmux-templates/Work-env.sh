#!/bin/bash

# Clear Current Windows
tmux kill-window -a

# Vimwiki Window
tmux new-window -c ~/vimwiki
tmux rename-window 'VimWiki'
tmux send-keys 'vim index.wiki' C-m
tmux split-window -v -p 20 -c ~/vimwiki

# Platform Repository
tmux new-window -c ~/dev/LDN_platform/ansible
tmux rename-window 'Ansible'
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/LDN_platform/ansible

# Env Repository
tmux new-window -c ~/dev/LDN_platform/puppet
tmux rename-window "Puppet"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/LDN_platform/puppet

# Terraform Repository
tmux new-window -c ~/dev/LDN_platform/iac
tmux rename-window "IAC"
tmux send-keys 'vim' C-m
tmux split-window -v -p 20 -c ~/dev/LDN_platform/iac

# Other Windows
tmux new-window -c ~/dev
tmux send-keys 'tmux move-window -r && clear' C-m
tmux rename-window 'ssh'

