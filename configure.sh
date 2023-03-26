#!/bin/bash

FILES=".vimrc .vim .bashrc .gitconfig"
BACKUP=$HOME/.backup

git submodule init
git submodule update

if [[ ! -e $BACKUP ]]; then
    mkdir "$BACKUP"
fi

cp .vim/autoload/vim-pathogen/autoload/pathogen.vim .vim/autoload/

if [[ ! -e .vim/autoload/pathogen.vim ]]; then
    cp .vim/autoload/vim-pathogen/autoload/pathogen.vim .vim/autoload/
fi

if [[ ! -e .vim/colors/solarized.vim ]]; then
    cp .vim/bundle/vim-colors-solarized/colors/solarized.vim .vim/colors/
fi
 
#echo "$FILES"

for f in $FILES;
do
#    echo "$f"
    if [[ -f $f ]]; then
        if [[ -e $HOME/$f ]]; then
            echo "Moving file $f to .backups/"
            mv $HOME/$f $BACKUP   
        fi
        echo "Copying file $f to $HOME"
        cp $f $HOME/
    elif [[ -d $f ]]; then
        if [[ -e $HOME/$f ]]; then
            echo "Moving directory $f to .backups/"
            if [[ -e $BACKUP/.vim ]]; then
                rm -r $BACKUP/.vim
            fi
            mv $HOME/$f $BACKUP
        fi
        echo "Copying directory $f to $HOME"
        cp -r $f $HOME/
    fi
done

echo "Done"
