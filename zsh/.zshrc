#!/bin/sh

export SHELL=/bin/zsh


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

. ~/.files/zsh/source.sh

if [ -e ~/.files.extra/zsh/source.sh ]; then
    . ~/.files.extra/zsh/source.sh
fi

. ~/.files/zsh/colors.sh
. ~/.files/zsh/prompt.sh
