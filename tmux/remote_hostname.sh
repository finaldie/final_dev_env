#!/bin/bash

pane_tty=`tmux display -p "#{pane_tty}" | cut -d "/" -f3,4`

target_host=`ps -af | awk -v ptty=$pane_tty '{if ($6 == ptty) print $0}' | grep -v grep | grep -oP "ssh [a-zA-Z0-9.@\-]+" | grep -vP "\ \-\w" | cut -d " " -f2 | grep -oP "(?=@*)[\w\d.\-]*" | tail -1`

# echo "tty: $pane_tty , host: $target_host"

echo $target_host
