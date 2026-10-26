#!/bin/bash

# Linux-only stuff. Abort if not Linux.
[[ "$OSTYPE" == linux-* ]] || return 1

export NVM_DIR="$HOME/.nvm"

# Lazy-load nvm - only initialize when node/npm/nvm commands are used
if [ -s "$(brew --prefix 2>/dev/null)/opt/nvm/nvm.sh" ]; then
  export PATH="$(brew --prefix)/opt/nvm/versions/node/$(cat $NVM_DIR/alias/default 2>/dev/null || echo 'v20.0.0')/bin:$PATH"

  nvm() {
    unset -f nvm node npm npx
    \. "$(brew --prefix)/opt/nvm/nvm.sh"
    \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
    nvm "$@"
  }

  node() {
    unset -f nvm node npm npx
    \. "$(brew --prefix)/opt/nvm/nvm.sh"
    \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
    node "$@"
  }

  npm() {
    unset -f nvm node npm npx
    \. "$(brew --prefix)/opt/nvm/nvm.sh"
    \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
    npm "$@"
  }

  npx() {
    unset -f nvm node npm npx
    \. "$(brew --prefix)/opt/nvm/nvm.sh"
    \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
    npx "$@"
  }
fi

