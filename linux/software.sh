#!/bin/sh

#shellcheck disable=SC1090
. ~/.files/setup/functions.sh

set -euo pipefail
IFS=$'\n\t'

heading "Setting up linux software"

if [[ ! "$(type -P zsh)" ]]; then
    echo you gotta apt-get zsh first
fi

# Ask for the administrator password upfront
sudo -v

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    heading "Installing Homebrew"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
fi

heading 'Running homebrew'
brew update
brew cleanup
brew doctor || exit 1

brew bundle --file=~/.files/linux/Brewfile

brew upgrade
brew cleanup

heading "Setting up apt packages"
sudo apt -y install gnupg2 gnupg-agent pinentry-gnome3
sudo apt install xclip

