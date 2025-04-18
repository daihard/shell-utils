#!/usr/bin/env bash
# vim: set filetype=sh:

vi () {
    if [[ -n "${DISPLAY:-}" ]] && command -v gvim >/dev/null 2>&1; then
        mygvim "$@"
    else
        command vim -- "$@" 2> /dev/null
    fi
}

cat () {
    # Use the GNU version if available (on macOS)
    if command -v gcat >/dev/null 2>&1; then
        cat_exec=gcat
    else
        cat_exec=cat
    fi

    if command -v highlight >/dev/null 2>&1; then
        highlight -O ansi --force "$@"
    else
        command ${cat_exec} -- "$@"
    fi
}

less () {
    if [[ $# -eq 0 ]]; then
        command less  # Handle empty arguments
        return # This preserves the status of "command less" above
    fi

    if command -v highlight >/dev/null 2>&1; then
        highlight -O ansi --force "$@" | command less -R
    else
        command less -- "$@"
    fi
}

# bash_env.sh defines functions that are used both interactively
# and in scripts.
script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")
in_file=${script_dir}/bash_env.sh
if [ -f $in_file ]; then
    . $in_file
fi
