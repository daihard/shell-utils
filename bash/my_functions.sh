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

function less () {
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

function cr () {
	local root_dir="$HOME"
    local len="${#root_dir}"
    local input_dir="$1"

    if [[ "$input_dir" == ".." || "${input_dir:0:3}" == "../" ]]; then
        cd "$input_dir" 
    elif [[ "${input_dir:0:$len}" == "${root_dir}" ]]; then
        # Input directory begins with "~/"
        cd "$input_dir" 
    else
        cd "$HOME/$input_dir"
    fi
}

# bash_env.sh defines functions that are used both interactively
# and in scripts.
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

