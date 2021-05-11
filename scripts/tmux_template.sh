#!/bin/bash

function new_tmux_session {
    SESSION_NAME=$(tmux display-message -p '#S')

    clear
    read -p "Name the Tmux session: " -r INPUT
    tmux has-session -t $INPUT
    if [ $? != 0 ]
    then
        tmux new-session -s $INPUT -d $1
        tmux switch-client -t $INPUT
        tmux kill-session -t $SESSION_NAME
    else
        echo "Session $INPUT already exists"
        exit
    fi
}

clear
SEARCH_DIR="$HOME/.dotfiles/tmux-templates"
cd $SEARCH_DIR

MESSAGE="Select a Tmux template: "
echo $MESSAGE

files=(* Exit)

cd ~/dev

PS3='Please enter your choice: '
select opt in "${files[@]}"
do
    case $opt in
        "Dev-env.sh")
            new_tmux_session "$SEARCH_DIR/$opt"
            ;;
        "Home-env.sh")
            new_tmux_session "$SEARCH_DIR/$opt"
            ;;
        "SC-env.sh")
            new_tmux_session "$SEARCH_DIR/$opt"
            ;;
        "Work-env.sh")
            new_tmux_session "$SEARCH_DIR/$opt"
            ;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

