#!/bin/sh

export SHELL=/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

. ~/.files/zsh/source.sh

if [ -e ~/.files.extra/zsh/source.sh ]; then
    . ~/.files.extra/zsh/source.sh
fi

. ~/.files/zsh/colors.sh
. ~/.files/zsh/prompt.sh
