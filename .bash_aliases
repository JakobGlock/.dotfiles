# General Aliases
# ------------------------------------------------------------------------------
alias ..='cd ..'
alias .-='cd -'
alias .~='cd ~'
alias lockscreen='i3lock-fancy -g -- scrot -z'
alias hibernate='systemctl suspend; lockscreen;'
alias sudo='sudo '
alias lsa='ls -lsah'

# Git Aliases
# ------------------------------------------------------------------------------
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias gb='git branch'
alias gcb='git branch | sed -n "/\* /s///p"'

# Tmux Aliases
# ------------------------------------------------------------------------------
alias tm='~/.dotfiles/scripts/tmux_template.sh'
alias tl='tmux ls'
alias tk='tmux kill-session'
alias tcs='tmux choose-session'

# Other Aliases
# ------------------------------------------------------------------------------
alias dotfiles='tmux new-window -n dotfiles -c ~/.dotfiles vim'
alias raidstat='watch -n 0.1 cat /proc/mdstat'
alias tf="terraform"
alias SCBoot='$HOME/.vim/bundle/scvim/bin/start_pipe'
alias mountSecret='sudo cryptsetup luksOpen /dev/sdb1 secret && sudo mount /dev/mapper/secret /mnt/tmp'
alias umountSecret='sudo umount /mnt/tmp && sudo cryptsetup luksClose /dev/mapper/secret'
alias playSleepbotRadio='nvlc ~/Music/RadioStations/SleepBotRadio.pls'
alias moc='mocp -m'
alias startJack='jackd -R -d alsa -r 44100 -p 2048 -S --device "hw:Generic,0"'
alias start-qjackctl="pasuspender -- qjackctl"
alias vimwiki="tmux new-window -n vimwiki -c ~/vimwiki vim -c VimwikiIndex"
alias deploy-vimwiki="ansible-playbook -i ~/dev/Ansible/hosts.ini ~/dev/Ansible/deploy_vimwiki.yml -K"
alias set-audio-hdmi="pactl set-default-sink 'alsa_output.pci-0000_0b_00.1.hdmi-stereo'"
alias set-audio-analog="pactl set-default-sink 'alsa_output.pci-0000_0d_00.3.analog-stereo'"
alias nb="newsboat"
alias teamspeak="/usr/local/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh"
alias makeart="tmux new-window -n art -c ~/dev/Python/Generative-Art vim; tmux splitw -h -p 40 -c ~/dev/Python/Generative-Art;"

# Work Aliases live somewhere else
# ------------------------------------------------------------------------------
if [ -f ~/.bash_aliases_work ]; then
    . ~/.bash_aliases_work
fi

