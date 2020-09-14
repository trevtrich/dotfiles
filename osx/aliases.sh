#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

alias afk="open -a ScreenSaverEngine"

alias showHidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias git=hub

#alias ctags if you used homebrew
alias ctags="`brew --prefix`/bin/ctags"

# Helpers for navigation
alias gaind="cd /Users/trevorr/Development/Gain"
alias home="cd /Users/trevorr/Development/Home"
