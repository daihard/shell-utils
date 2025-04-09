#!/usr/bin/env bash
# vim: set filetype=sh:


myvim() {
    if [[ -n "${DISPLAY:-}" ]] && command -v gvim >/dev/null 2>&1; then
        mygvim "$@"
    else
        vim "$@" 2> /dev/null
    fi
}

ccat() {
    if command -v highlight >/dev/null 2>&1; then
        highlight -O ansi --force "$@"
    else
        cat "$@"
    fi
}

cless() {
    if command -v highlight >/dev/null 2>&1; then
        highlight -O ansi --force "$@" | \less -R
    else
        \less "$@"
    fi
}

alias vi='myvim'
alias cat='ccat'
alias less='cless'

script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")
in_file=${script_dir}/bash_env.sh
if [ -f $in_file ]; then
    . $in_file
fi
