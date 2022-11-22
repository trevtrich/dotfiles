#!/bin/sh

export SHELL=/bin/bash
#export FORCE_COLOR=1
#export NPM_CONFIG_COLOR=always
#export BASH_SILENCE_DEPRECATION_WARNING=1

eval "$(/opt/homebrew/bin/brew shellenv)"

. ~/.files/bash/source.sh

if [ -e ~/.files.extra/bash/source.sh ]; then
    . ~/.files.extra/bash/source.sh
fi
