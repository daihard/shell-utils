#!/usr/bin/env bash

script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")
## echo "The file is in $script_dir"

in_file=${script_dir}/my_dircolors.sh
if [ -f $in_file ]; then
    . $in_file
fi

in_file=${script_dir}/my_aliases.sh
if [ -f $in_file ]; then
    . $in_file
fi

in_file=${script_dir}/my_work.sh
if [ -f $in_file ]; then
    . $in_file
fi

in_file=${script_dir}/my_prompt.sh
if [ -f $in_file ]; then
    . $in_file
fi

in_file=${script_dir}/my_functions.sh
if [ -f $in_file ]; then
    . $in_file
fi

