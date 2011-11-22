#!/bin/bash

set -e

rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# deploy
for f in vimrc gitconfig gitignore zshrc zsh vim
do
    if [ -e ~/.${f} ]; then
        mv ~/.${f} dotfiles-backup/${f}
    fi
    ln -sf `pwd`/${f} ~/.${f}
done

if [ ! -e ~/.zshrc-local ]; then
    cp zshrc-local ~/.zshrc-local
fi
