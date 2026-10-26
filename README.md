# My .files

My disaster recovery plan.

## Purpose

This repository contains most of my base configuration, but is
primarily focused on OSX and linux. These files make it simple to configure a new machine
from scratch as well as keep it up-to-date over time.

## Installation

### Prerequisites

* `git` must be installed
* Homebrew is installed
* pyenv is installed from homebrew

#### Linux

* in order to use homebrew, install [the homebrew recommended packages](https://docs.brew.sh/Homebrew-on-Linux#requirements):
  * `sudo apt-get install build-essential procps curl file git`
  * `sudo apt-get install zsh`


### Command

```sh
git clone https://github.com/trevtrich/dotfiles.git && cd dotfiles/setup/ && source init.sh
```

## What does it do?

### System Bootstrapping

`setup/init.sh` presents three options:

* Environment configuration
* Software Installation/Update
* Both

#### Environment Configuration

* Creates a symlink for `~/.files` in the home directory
* Symlinks dotfiles (files/folders starting with `.`) from each folder under `~/.files` into the home directory
* Symlinks the OS-specific gitconfig to `~/.gitconfig.os`
* Creates `~/bin`
* Symlinked `.zshrc` sources several files in order to:
  * Define environment variables
  * Define aliases and functions
  * Enable vi-mode input and my custom prompt
  * Source additional files from `~/.files/osx/` and `~/.files/linux/`
  * Source `~/.files.extra/zsh/source.sh` (private, machine/work-specific config and secrets)

##### macOS

* Configures OSX defaults

#### Software Installation/Update

##### macOS Software

* Installs [Homebrew](http://brew.sh/)
* Installs the applications defined in:
  * `~/.files/osx/Brewfile`
  * `~/.files.extra/osx/Brewfile`

##### Linux Software

* Installs [Homebrew](http://brew.sh/)
* Installs the applications defined in:
  * `~/.files/linux/Brewfile`
* Installs some useful Debian packages through `apt`
  * To get ergodox software working, use [this website](https://github.com/zsa/wally/wiki/Linux-install)

## Supported Environments

The following environments are the ones that this configuration has been tested
in by me, in order from most often to least often used.

* zsh on macOS (Apple Silicon)
* zsh on Ubuntu

## Verification

There is no automated test suite. To sanity-check a change:

```sh
zsh -n <file>          # syntax check
zsh -i -c exit         # interactive shell starts cleanly
time zsh -i -c exit    # startup stays fast
shellcheck <file>      # lint, if installed
```

## Influences

Strongly influenced by:

* <https://github.com/mathiasbynens/dotfiles>
* <https://github.com/cowboy/dotfiles>
