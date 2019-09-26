#!/bin/bash


FILES_TO_INSTALL=$(find . -maxdepth 1 -type f -not -name .git -not -name setup.sh -printf '%f\n')
FILES_TO_INSTALL="$FILES_TO_INSTALL vim"


main() {
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    for file in $FILES_TO_INSTALL; do

        sourceFile="$(pwd)/$file"
        targetFile="$HOME/$(printf ".%s" "$file" | sed "s/.*\/\(.*\)/\1/g")"

    	ln -s $sourceFile $targetFile 

    done

    vim +PluginInstall +qall

}

main


#TODO: backup and remove existing old files before making links
