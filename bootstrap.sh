#!/bin/bash

info () {
    printf "  [ \033[00;34m..\033[0m ] $1"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

link_files () {
    ln -s $1 $2
    success "linked $1 to $2"
}


info 'Brew bundle'
brew bundle

#should check for existence of ~/.dotfiles
#if not there, ask for path to clone the git repository to
#and add a simlink at ~/.dotfiles
