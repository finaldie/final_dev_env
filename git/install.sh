#!/bin/sh -x

source $FENVTOP/modules.txt

echo "" >> ~/.bash_profile
echo "# This is for git user-specific config folder, the $FENVTOP/git/config settings" >> ~/.bash_profile
echo "# will be overwritten the global's settings(~/.gitconfig)" >> ~/.bash_profile
echo "export XDG_CONFIG_HOME=$FENVTOP" >> ~/.bash_profile
