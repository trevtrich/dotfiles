#!/bin/zsh

# Homebrew — keep first so `brew` is on PATH for everything below.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by Toolbox App
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# NON-interactive login shells (e.g. Conductor setup/run scripts and anything
# that snapshots the login environment) read .zprofile but never .zshrc, so they
# never reach the export chain that loads nvm. Source it here for those shells
# so nvm/node and the rest of our environment are available to them.
#
# Interactive login shells (Terminal) are skipped on purpose: .zshrc sources the
# same chain, and it must load nvm LAST — after .zshrc re-runs `brew shellenv` —
# or Homebrew's node would shadow the nvm node on PATH. Loading it here too would
# both regress that ordering and double-source nvm.
if [[ ! -o interactive ]]; then
    #shellcheck disable=SC1090
    [ -r ~/.files/zsh/exports.sh ] && . ~/.files/zsh/exports.sh
fi
