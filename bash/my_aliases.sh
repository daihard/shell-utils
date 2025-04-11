#!/usr/bin/env bash
# my_aliases for Bash

# Common aliases between Linux and macOS
alias cp='cp -ip'
alias grep='grep -n'

if [ "$(uname -s)" == "Darwin" ]; then
    # These assume the following packages are installed via Homebrew
    # coreutils
    alias df='gdf'
    alias ls='gls --ignore=".DS_*" --group-directories-first --color=auto'
    # alias ls='LC_COLLATE=C ls --color=auto'
    
    # findutils
    alias find='gfind'
    
    # gnu-sed
    alias sed='gsed'
fi
