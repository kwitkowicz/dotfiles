#!/bin/bash


FILES_TO_INSTALL=$(find . -maxdepth 1 -type f -not -name .git -not -name setup.sh -printf '%f\n')
BACKUP_DIR=~/dotfiles_old

install_ctags(){
    myDir="$(pwd)"
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure --prefix=$HOME
    make
    make install
    cd $myDir
}

install_some_stuff(){
    pip3 install flake8
    pip3 install bashate #style checker for bash scripts used by OpenStack

    sudo dnf install cmake gcc-c++ make python3-devel
    sudo dnf install golang
    sudo dnf install npm
}

main() {
    install_ctags
    install_some_stuff
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


    mkdir -p $BACKUP_DIR

    for file in $FILES_TO_INSTALL; do

        sourceFile="$(pwd)/$file"
        targetFile="$HOME/$(printf ".%s" "$file" | sed "s/.*\/\(.*\)/\1/g")"

        cp -Lr --remove-destination $targetFile $BACKUP_DIR
        rm -rf $targetFile

        ln -s $sourceFile $targetFile

    done

    vim +PluginInstall +qall

}

main


#TODO: backup and remove existing old files before making links
