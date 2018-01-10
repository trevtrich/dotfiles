#!/bin/sh

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
elif ls -G > /dev/null 2>&1; then # OS X `ls`
    colorflag="-G"
else
    colorflag=""
fi

# shellcheck disable=SC2139
alias ls="ls ${colorflag} -F"
alias ll="ls -al"

alias hosts='sudo $EDITOR /etc/hosts'

alias reload='exec -l $SHELL'

alias ccat="source-highlight --out-format=esc -o STDOUT -i"

alias vim-plugins="vim +PluginInstall! +qall"

#alias ctags if you used homebrew
alias ctags="`brew --prefix`/bin/ctags"

#shellcheck disable=SC1090
. "$HOME/.files/osx/aliases.sh"
