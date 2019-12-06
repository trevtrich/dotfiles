#!/bin/bash
#shellcheck disable=SC1090

#source ~/.files/gpg/init.sh

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

export NVM_DIR="$(realpath $HOME/.nvm)"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

[[ -s ~/.avn/bin/avn.sh ]] && source ~/.avn/bin/avn.sh
