#!/usr/bin/env bash
# my_aliases for Bash

if [ "$(uname -s)" == "Darwin" ]; then
    script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")
    in_file=${script_dir}/macos/my_aliases.sh
    if [ -f $in_file ]; then
        . $in_file
    fi
fi
