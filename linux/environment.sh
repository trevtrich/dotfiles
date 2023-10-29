#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == linux-* ]] || return 1

heading 'Configuring Linux'

# Ask for the administrator password upfront
sudo -v

echo "Done. Note that some of these changes require a logout/restart to take effect."
