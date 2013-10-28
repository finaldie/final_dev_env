#!/bin/sh -x

export FENVTOP=`pwd`
source ./modules.txt

# create the output folder
if [ ! -d $output ]; then
    mkdir -p $output/$backup
fi

for module in $modules
do
    echo "processing $module..."
    cd $module; ./install.sh || exit "[$?]: Install $module failed"; cd -
    echo "processing $module done"
done

echo "dev environment install complete"
