#!/bin/zsh

# normal alias
alias ls='ls -F'
alias la='ls -aF'
alias ll='ls -aFlh'
alias sl='ls -F'
alias rm='rm -r'
alias cp='cp -R'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR=vim

# zsh completion ignore case
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE
setopt no_list_ambiguous
