#!/bin/bash
#shellcheck disable=SC1090

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1
