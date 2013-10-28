#!/bin/sh

envtop=`pwd`
bashdir=$envtop/bash

# if some components need to be installed, put the orders here.

############ Bash Environment #############
echo "Installing bash environment..."
if [ ! -f ~/.bash_profile ]; then
    touch ~/.bash_profile
fi

echo "\n# The following lines from final_dev_env" >> ~/.bash_profile
echo "export FENVTOP=$envtop" >> ~/.bash_profile
cat $bashdir/main.bashrc >> ~/.bash_profile

echo "Install bash environment complete"
############ Bash Environment End #############
