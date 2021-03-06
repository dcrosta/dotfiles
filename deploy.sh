#!/bin/bash

set -e

rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# deploy
for f in $(cat DOTFILES)
do
    if [ -e ~/.${f} ]; then
        mv ~/.${f} dotfiles-backup/${f}
    fi
    ln -sf `pwd`/${f} ~/.${f}
done

if [ -e ~/.virtualenvs ]; then
    mkdir -p dotfiles-backup/virtualenvs/

    for f in `ls -1 virtualenvs`
    do
        [ -e "~/.virtualenvs/${f}" ] && mv ~/.virtualenvs/${f} dotfiles-backup/virtualenvs/${f}
        ln -sf `pwd`/virtualenvs/${f} ~/.virtualenvs/${f}
    done
fi

if [ ! -e ~/.zshrc-local ]; then
    cp zshrc-local ~/.zshrc-local
fi
