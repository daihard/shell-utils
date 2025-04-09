#!/usr/bin/env bash
# My aliases for macoS

# Fail if this file is used on a non-macOS platform
[ "$(uname -s)" = "Darwin" ] || { echo "macOS required" >&2; exit 1; }

# These assume the following packages are installed via Homebrew
# * coreutils
alias df='gdf'
alias ls='gls --ignore=".DS_*" --group-directories-first --color=auto'
# alias ls='LC_COLLATE=C ls --color=auto'

# * findutils
alias find='gfind'

# * gnu-sed
alias sed='gsed'

