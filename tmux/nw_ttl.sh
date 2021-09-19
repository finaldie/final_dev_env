#!/bin/bash

target_host=`bash ~/.tmux/remote_hostname.sh`

# echo "tty: $pane_tty , host: $target_host"

ping -c 1 $target_host | tail -1 | cut -d "/" -f5

# (ping -c 1 #(ps -af | grep "`tmux display -p \"#{pane_tty}\" | cut -d \"/\" -f3,4` " | grep -v grep | grep -oP "ssh [a-zA-Z0-9.@\-]+" | cut -d " " -f2 | grep -oP "(?=@*)[\w\d.\-]*" | tail -1) | tail -1 | cut -d "/" -f5)
