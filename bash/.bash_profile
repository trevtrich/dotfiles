#!/bin/sh

export FORCE_COLOR=1
export NPM_CONFIG_COLOR=always

. ~/.files/bash/source.sh

if [ -e ~/.files.extra/bash/source.sh ]; then
    . ~/.files.extra/bash/source.sh
fi
