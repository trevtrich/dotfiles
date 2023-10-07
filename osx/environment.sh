#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

heading 'Configuring  OS X'

# Ask for the administrator password upfront
sudo -v

###############################################################################
# Bash                                                                        #
###############################################################################

# Change the default shell to bash v4
#if [ -e '/usr/local/bin/bash' ] && ! grep '/usr/local/bin/bash' /etc/shells; then
#  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
#  chsh -s /usr/local/bin/bash;
#  info 'Default shell changed to bash'
#fi;

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Done. Note that some of these changes require a logout/restart to take effect."
