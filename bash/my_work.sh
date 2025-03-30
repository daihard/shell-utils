#!/usr/bin/env bash

script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")

if [ "$(uname -s)" == "Linux" ]; then
    in_file=${script_dir}/linux/my_work.sh
elif [ "$(uname -s)" == "Darwin" ]; then
    in_file=${script_dir}/macos/my_work.sh
fi

if [ -f $in_file ]; then
    . $in_file
fi

# Sverre's scripts

function rcd {
    cd "$(reldir $1)"
}

function scd {
    cd "$(searchdir $1)"
}
