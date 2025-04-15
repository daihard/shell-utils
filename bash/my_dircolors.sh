#!/usr/bin/env bash

if [ "$(uname -s)" = "Darwin" ]; then
    # If GNU dircolors is installed, run it to use Linux-like colours
    if command -v gdircolors >/dev/null 2>&1; then
        test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    fi
fi

