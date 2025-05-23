#!/usr/bin/env bash
# my_aliases for Bash

# Common aliases between Linux and macOS
alias grep='grep -n --color=auto'

if [ "$(uname -s)" = "Darwin" ]; then
    # These assume the following packages are installed via Homebrew
    # coreutils
    alias cp='gcp -ip'
    alias df='gdf'
    alias ls='gls --ignore=".DS_*" --group-directories-first --color=auto'
    
    # findutils
    alias find='gfind'
    
    # gnu-sed
    alias sed='gsed'
elif [ "$(uname -s)" = "Linux" ]; then
    alias cp='cp -ip'
    alias kt='kate'

    # Fix the new annoying behaviour of ls...
    unalias ls
    ##alias ls='ls --color=auto --escape'
    alias ls='LC_COLLATE=C ls --group-directories-first --color=auto'
fi
