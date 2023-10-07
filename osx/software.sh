#!/bin/bash

#shellcheck disable=SC1090
. ~/.files/setup/functions.sh

set -euo pipefail
IFS=$'\n\t'

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || exit 1

# Ask for the administrator password upfront
sudo -v

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
    heading "Installing Homebrew"

    #Skip the "Press enter to continue…" prompt.
    true | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

heading 'Brew bundle'
brew update
brew cleanup
brew doctor || exit 1
brew bundle --file=~/.files/osx/Brewfile
if [ -e ~/.files.extra/osx/Brewfile ]; then
   brew bundle --file=~/.files.extra/osx/Brewfile
fi
brew upgrade
brew cleanup

# Install ohmyzsh.
if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh is already installed"
 else
    heading "Installing ohmyzsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d ~/.nvm ]]; then
    heading "Finishing nvm configuration"

    mkdir ~/.nvm
    cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
    link_file "$(brew --prefix nvm)/nvm.sh" ~/.nvm/nvm.sh
fi
