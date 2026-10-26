#!/bin/zsh

#shellcheck disable=SC1090
. ~/.files/osx/exports.sh
. ~/.files/linux/exports.sh

export PATH="$HOME/bin:$PATH"

# Make vim the default editor
export EDITOR="vim";

export DOCKER_HOST=unix:///Users/trevorr/.colima/default/docker.sock

export VITEST_MAX_FORKS=5

# MAILOSAUR_API_KEY, FONTAWESOME_TOKEN, SONAR_TOKEN live here, outside the repo
if [ -e ~/.files.extra/zsh/secrets.sh ]; then
    #shellcheck disable=SC1090
    . ~/.files.extra/zsh/secrets.sh
fi
