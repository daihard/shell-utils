#!/usr/bin/env bash

# Sverre's scripts
function rcd {
    cd "$(reldir $1)"
}

function scd {
    cd "$(searchdir $1)"
}

script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")

if [ "$(uname -s)" == "Darwin" ]; then
    in_file=${script_dir}/my_work_macos.sh
elif [ "$(uname -s)" == "Linux" ]; then
    source /etc/os-release
    if [ "$ID" == "ubuntu" ]; then
        in_file=${script_dir}/my_work_ubuntu.sh
    else
        return 0
    fi
fi

if [ -f $in_file ]; then
    . $in_file
fi

