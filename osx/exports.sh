#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications";

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=true
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=true

export AWS_REGION=us-east-1
export AWS_PROFILE=claimable

export NVM_DIR="$HOME/.nvm"

# Lazy-load nvm - only initialize when node/npm/nvm commands are used
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  export PATH="/opt/homebrew/opt/nvm/versions/node/$(cat $NVM_DIR/alias/default 2>/dev/null || echo 'v20.0.0')/bin:$PATH"

  nvm() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    nvm "$@"
  }

  node() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    node "$@"
  }

  npm() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    npm "$@"
  }

  npx() {
    unset -f nvm node npm npx
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    npx "$@"
  }
fi

# Add Claude Code native installation to PATH
export PATH="$HOME/.local/bin:$PATH"
