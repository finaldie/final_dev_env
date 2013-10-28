#!/bin/sh

envtop=`pwd`
subdirs="bash"
output=output

sub_extension=subext.bashrc
extension_bashrc=ext.bashrc
extension_bashrc_tmp=.ext.bashrc
extension_bashrc_backup=ext.bashrc.bak

temp_extension=$envtop/$output/$extension_bashrc_tmp
final_extension=$envtop/$output/$extension_bashrc
backup_extension=$envtop/$output/$extension_bashrc_backup

function generate_extension_bashrc()
{
    bashrc_file=$1
    target=$2

    echo "" >> $target
    echo "if [ -f $bashrc_file ]; then" >> $target
    echo "    . $bashrc_file" >> $target
    echo "fi" >> $target
}

function link2bashprofile()
{
    echo "Installing bash environment..."
    if [ ! -f ~/.bash_profile ]; then
        touch ~/.bash_profile
    fi

    # link the final extension bashrc file to bash_profile, and if we found the
    # extension file already exist in the output folder, that means, the link already
    # set up, so we won't link it again
    if [ ! -f $envtop/$output/.installed ]; then
        # add a title
        echo "" >> ~/.bash_profile
        echo "# The following lines from final_dev_env" >> ~/.bash_profile
        echo "export FENVTOP=$envtop" >> ~/.bash_profile

        generate_extension_bashrc $final_extension ~/.bash_profile
        touch $envtop/$output/.installed
    fi

    echo "Install bash environment complete"
}

# if some components need to be installed, put the orders here.

# 0. prepare
# create the output folder
if [ ! -d $output ]; then
    mkdir $output
fi

export FENVTOP=$envtop

# 1. generate the temp extension bashrc
for subdir in $subdirs
do
    if [ -f $subdir/$sub_extension ]; then
        echo "Enter $subdir"
        generate_extension_bashrc $envtop/$subdir/$sub_extension $temp_extension
        echo "Exit $subdir"
    fi
done

# 2. create or update extension bashrc
if [ ! -f $final_extension ]; then
    mv $temp_extension $final_extension
else
    old_md5=`md5sum $final_extension | awk '{print $1}'`
    new_md5=`md5sum $temp_extension | awk '{print $1}'`

    if [ $old_md5 != $new_md5 ]; then
        mv $final_extension $backup_extension
        mv $temp_extension $final_extension
    else
        echo "extension bashrc is the same as before"
    fi
fi

# 3. link the extension bashrc to bash_profile
link2bashprofile
