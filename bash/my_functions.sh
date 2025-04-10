#!/usr/bin/env bash
# vim: set filetype=sh:

myvim () {
    if [[ -n "${DISPLAY:-}" ]] && command -v gvim >/dev/null 2>&1; then
        mygvim "$@"
    else
        vim "$@" 2> /dev/null
    fi
}

ccat () {
    # Use the GNU version if available (on macOS)
    if command -v gcat >/dev/null 2>&1; then
        cat_exec=gcat
    else
        cat_exec=cat
    fi

    if command -v highlight >/dev/null 2>&1; then
        highlight -O ansi --force "$@"
    else
        ${cat_exec} "$@"
    fi
}

cless () {
    if command -v highlight >/dev/null 2>&1; then
        highlight -O ansi --force "$@" | \less -R
    else
        \less "$@"
    fi
}

alias vi='myvim'
alias cat='ccat'
alias less='cless'

# bash_env.sh defines functions that are used both interactively
# and in scripts.
script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")
in_file=${script_dir}/bash_env.sh
if [ -f $in_file ]; then
    . $in_file
fi
