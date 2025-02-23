#!/bin/bash

declare -a color_list

# Return success if the specified colour is usable (i.e. dark)
function use_this_color ()
{
    local ret=0
    local bad_color_list=("aqua" "calmbreeze" "default" "delek" "fine_blue" "morning" "olive" "shine" "tolerable" "zellner")

    for bad_color_name in "${bad_color_list[@]}"; do
        if [ "$1" == "$bad_color_name" ]; then
            #echo "Bad color ==> $1"
            ret=1
            break
        fi
    done

    return $ret
}

vim_dir="/home/dtoyama/.vim/colors"
counter=0

for ii in $vim_dir/*.vim; do
    if [ -f $ii ]; then
        color_name=$(basename "$ii" .vim)
        if use_this_color $color_name; then
            color_list[$counter]=$color_name
            counter=`expr $counter + 1`
        fi
    fi
done

color_count="${#color_list[*]}"

# Generate a (semi) random number within that range
number=`date +%s`
random=`expr $number % $color_count`

# Return the colour based on the random number
echo "${color_list[$random]}"

