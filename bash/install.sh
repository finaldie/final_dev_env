#!/bin/bash

# include common variables
source $FENVTOP/modules.txt

sub_extension=subext.bashrc
extension_bashrc=ext.bashrc
extension_bashrc_tmp=.ext.bashrc
extension_bashrc_backup=ext.bashrc.bak

temp_extension=$OUTPUT/$extension_bashrc_tmp
final_extension=$OUTPUT/$extension_bashrc
backup_extension=$OUTPUT/$extension_bashrc_backup

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
    if [ ! -f ~/.bash_profile ]; then
        touch ~/.bash_profile
    fi

    # link the final extension bashrc file to bash_profile, and if we found the
    # extension file already exist in the output folder, that means, the link already
    # set up, so we won't link it again
    if [ ! -f $OUTPUT/.installed ]; then
        # add a title
        echo "" >> ~/.bash_profile
        echo "# The following lines from final_dev_env" >> ~/.bash_profile
        echo "export FENVTOP=$FENVTOP" >> ~/.bash_profile

        generate_extension_bashrc $final_extension ~/.bash_profile
        touch $OUTPUT/.installed
    fi

    echo "linked extension bashrc to bash_profile complete"
}

# 0. add title
echo "#!/bin/bash" > $temp_extension

# 1. generate the temp extension bashrc
for subdir in $modules
do
    if [ -f $FENVTOP/$subdir/$sub_extension ]; then
        echo "Enter $subdir"
        generate_extension_bashrc $FENVTOP/$subdir/$sub_extension $temp_extension
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
        mv $final_extension $BACKUP/$backup_extension
        mv $temp_extension $final_extension
    else
        echo "extension bashrc is the same as before"
        rm -f $temp_extension
    fi
fi

# 3. link the extension bashrc to bash_profile
link2bashprofile
