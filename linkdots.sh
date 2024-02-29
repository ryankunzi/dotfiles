#!/bin/bash

FILES=".bashrc .ctags .gitconfig .tmux .tmux.conf .toprc .vimrc .vim"

#git submodule init
#git submodule update

#echo "$FILES"

for f in $FILES;
do
    ln -v -s $(pwd)/$f $HOME
done

echo "Done"
