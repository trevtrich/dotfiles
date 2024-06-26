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

## Gettin the system functional with my tools
sudo apt -y install gnupg2 gnupg-agent pinentry-gnome3
sudo apt install xclip

# Allows app-image. see [Can't run an AppImage on Ubuntu 20.04](https://askubuntu.com/questions/1363783/cant-run-an-appimage-on-ubuntu-20-04)
# i needed this for jetbrains toolbox
sudo apt install libfuse2

## Development
sudo apt install elixir


if [[ ! -d ~/.nvm ]]; then
    heading "Finishing nvm configuration"

    mkdir ~/.nvm
    cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
    link_file "$(brew --prefix nvm)/nvm.sh" ~/.nvm/nvm.sh
fi
