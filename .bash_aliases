# General Aliases
# -----------------------------------------------------------------------------
alias ..='cd ..'
alias .-='cd -'
alias .~='cd ~'
alias hibernate='systemctl suspend'
alias sudo='sudo '
alias lsa='ls -lsah'

# Git Aliases
# -----------------------------------------------------------------------------
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias gb='git branch'

# Tmux Aliases
# -----------------------------------------------------------------------------
alias tm='~/.dotfiles/scripts/tmux_template.sh'
alias tl='tmux ls'
alias tk='tmux kill-session'
alias tcs='tmux choose-session'

# Other Aliases
# -----------------------------------------------------------------------------
alias dotfiles='cd ~/.dotfiles && vim'
alias raidstat='watch -n 0.1 cat /proc/mdstat'
alias tf="terraform"
