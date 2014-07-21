#!/bin/bash

PS1='\[\033[01;32m\]\u@\h:\[\033[01;33m\] \w>\[\033[00m\]'

# normal alias
alias ls='ls -F'
alias la='ls -aF'
alias ll='ls -aFlh'
alias sl='svn log --limit 10'
alias rm='rm -r'
alias cp='cp -R'

# sha1
alias sha1check='openssl dgst -sha1 -hmac '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# add timestamp in history list
export HISTTIMEFORMAT='%F %T '
# enable history appending instead of overwriting.
shopt -s histappend

# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# ignore specify history
export HISTIGNORE="ls:pwd:ll"

# let history limit to 1000
export HISTSIZE=1000
export HISTFILESIZE=1000

# color
export LSCOLORS=DxGxFxdxCxegedabagExEx
export CLICOLOR=yes
set autolist

function tcp_status() {
    netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
}

# ulimit
# generate coredump file with unlimited size
ulimit -c unlimited

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
