#!/bin/zsh

# completion of docker commands
#if which docker > /dev/null 2>&1; then
#    #shellcheck disable=SC1090
#    . ~/.files/docker/bash_completion.sh
#fi
source <(fzf --zsh)

#shellcheck disable=SC1090
. ~/.files/osx/completion.sh
