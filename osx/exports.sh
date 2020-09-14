#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

export PATH
export M2_HOME
export M2

PATH=/usr/local/bin:/usr/local/sbin:/usr/local/opt/gpg-agent/bin:$(brew --prefix python)/libexec/bin:$(brew --prefix ruby)/bin:~/.local/bin:$PATH
M2_HOME=$(brew --prefix maven)/libexec
M2="${M2_HOME}/bin"

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications";

# Use silver searcher fzf
export FZF_DEFAULT_COMMAND='ag -l --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
