#!/bin/zsh

heading 'Link Dotfiles'
link_dotfiles
link_gitconfig_for_os
reload

if [ ! -d ~/bin ]; then
    heading 'Creating ~/bin'
    mkdir ~/bin
fi

. ../osx/environment.sh
. ../linux/environment.sh
. ../windows/environment.sh
