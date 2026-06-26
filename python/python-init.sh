#!/bin/sh

# Lazy-load pyenv - only initialize when python/pyenv commands are used
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

pyenv() {
  unset -f pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}
