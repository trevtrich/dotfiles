#!/bin/bash

# completion of npm commands
if which npm > /dev/null 2>&1; then
    #shellcheck disable=SC1090
    npm completion > /usr/local/etc/bash_completion.d/npm
fi

# completion of docker commands
if which docker > /dev/null 2>&1; then
    #shellcheck disable=SC1090
    . ~/.files/docker/bash_completion.sh
fi


#shellcheck disable=SC1090
. ~/.files/osx/completion.sh
