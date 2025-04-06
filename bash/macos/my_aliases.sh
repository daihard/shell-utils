#!/usr/bin/env bash
# My aliases for macoS

# Fail if this file is used on a non-macOS platform
[ "$(uname -s)" = "Darwin" ] || { echo "macOS required" >&2; exit 1; }

alias vi='mygvim'
alias cp='cp -ip'
alias grep='grep -n'

# These assume the following packages are installed via Homebrew
# * coreutils
# * findutils
alias df='gdf'
alias find='gfind'

# Fix the new annoying behaviour of ls...
##alias ls='ls --color=auto --escape'
alias ls='LC_COLLATE=C ls --color=always'
