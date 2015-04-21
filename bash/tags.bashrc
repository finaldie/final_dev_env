#!/bin/bash

## ctags
alias buildc_tags='ctags -R -I __THROW --sort=yes --c-kinds=+p --fields=+liaS --extra=+q -f .tags'
alias buildcpp_tags='ctags -R --sort=yes --c++-kinds=+p --fields=+liaS --extra=+q -f .tags'

tags_folder='/tmp/tags'
function build_localsys_tags() {
    echo "generate local include tags..."
    if [ ! -d $tags_folder ]; then
        sudo mkdir $tags_folder
    fi
    sudo ctags -R -f $tags_folder/local_tags -I __THROW --sort=yes --c++-kinds=+p --fields=+liaS --extra=+q /usr/local/include
    echo "generate local include tags [ok]"
}

function build_sys_tags() {
    echo "generating system tags..."
    if [ ! -d $tags_folder ]; then
        sudo mkdir $tags_folder
    fi
    sudo ctags -R -f $tags_folder/systags -I __THROW --sort=yes --c++-kinds=+p --fields=+liaS --extra=+q  /usr/include/	
    echo "generate system tags [ok]"
}

function buildsys_tags() {
    ctags --version

    build_sys_tags
    build_localsys_tags
}

function build_cscope() {
    find $1 -name "*.h" -o -name "*.c" -o -name "*.*pp" -o -name "*.m" -o -name "*.hh" -o -name "*.cc" -o -name "*.java" > cscope.files
    cscope -Rbkq -i cscope.files -f .cscope.out
    rm -f cscope.files
}

function build_tags() {
    echo "generating tags file..."
    buildcpp_tags $(pwd)
    echo "generate tags [ok]"

    echo "generating cscope files..."
    build_cscope $(pwd)
    echo "generate cscope database [ok]"
}

function cleanall_tags() {
    rm -f .cscope.* .tags
    rm -f types_c.taghl
    echo "clean all tags done!"
}
