#!/bin/sh

alias ll="ls -al"
alias reload='exec -l $SHELL'

#shellcheck disable=SC1090
. "$HOME/.files/osx/aliases.sh"

if [ -f $HOME/.files.extra/bash/aliases.sh ]; then
    . "$HOME/.files.extra/bash/aliases.sh"
fi
