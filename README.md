# My .files

[![Build Status](http://img.shields.io/travis/travi/dotfiles.svg?style=flat)](https://travis-ci.org/travi/dotfiles)
[![Code Climate](https://img.shields.io/codeclimate/github/travi/dotfiles.svg)](https://codeclimate.com/github/travi/dotfiles)

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


### Command

```sh
git clone https://github.com/trevtrich/dotfiles.git && cd dotfiles/setup/ && source init.sh
```

## What does it do?

### System Bootstrapping

`setup/init.sh` presents two options:

* Environment configuration
* Software Installation/Update

#### Environment Configuration

* Creates a symlink for `~/.dotfiles` in the home directory
* Symlinks dotfiles from each folder under `~/.dotfiles` into the home directory
* Symlinks dotfiles from each folder under `~/.dotfiles.extra` into the home directory
* Symlinks maven plugins into global plugins directory
* Symlinked `.bash_profile` sources several files in order to:
  * Define environment variables
  * Define aliases
  * Enable my custom prompt
  * Source additional files from `~/.dotfiles/osx/` and `~/.dotfiles/windows/`
  * Source `~/.dotfiles.extra/bash/source.sh`

##### macOS

* Configures OSX defaults

#### Software Installation/Update

* Updates global NPM packages
* Installs/Updates VIM plugins

##### macOS Software

* Installs [Homebrew](http://brew.sh/)
* Installs the applications defined in:
  * `~/.dotfiles/osx/Brewfile`
  * `~/.dotfiles.extra/osx/Brewfile`

##### Linux Software

* Installs [Homebrew](http://brew.sh/)
* Installs the applications defined in:
  * `~/.dotfiles/linux/Brewfile`
* Installs some useful Debian packages through `apt-get`
  * To get ergodox software working, use [this website](https://github.com/zsa/wally/wiki/Linux-install)

## Supported Environments

The following environments are the ones that this configuration has been tested
in by me, in order from most often to least often used.

* Terminal.app on macOS (Sierra is my primary)
* GitBash on Windows
* SSH sessions into Ubuntu

## Verification

### Execute

With [Vagrant]() available, you can run the full verification locally:

```sh
rake --rakefile=test/Rakefile
```

If Vagrant isn't installed, or you want to only run the lint checks:

```sh
rake --rakefile=test/Rakefile lint
```

### What's included

* Lint

  * Shellcheck for shell scripts
  * Markdownlint for markdown files

* Behavioral tests

  * TestKitchen to verify that a fresh machine would be configured appropriately
    (coverage is sparse for these tests at this point)

## Influences

Strongly influenced by:

* <https://github.com/mathiasbynens/dotfiles>
* <https://github.com/cowboy/dotfiles>
