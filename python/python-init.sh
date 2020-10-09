#!/bin/sh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pip install jedi # needed by coc-python
