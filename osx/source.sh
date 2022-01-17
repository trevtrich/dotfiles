#!/bin/bash
#shellcheck disable=SC1090

#source ~/.files/gpg/init.sh

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

export NVM_DIR="$(realpath $HOME/.nvm)"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[[ -s ~/.avn/bin/avn.sh ]] && source ~/.avn/bin/avn.sh

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
