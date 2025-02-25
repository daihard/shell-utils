#!/bin/bash

declare -a bad_color_list

function create_bad_color_list ()
{
    local bad_color_file="$HOME/.vim/bad_colors.txt"

    if [ -f "$bad_color_file" ]; then
        local counter=0
        while read -r line; do
            bad_color_list[$counter]="$line"
            counter=`expr $counter + 1`
        done < $bad_color_file
    fi
}

create_bad_color_list

# Return success if the specified colour is usable (i.e. dark)
function use_this_color ()
{
    local ret=0

    ## This works even if the list of bad colours is empty,
    ## in which case the function returns success (0)
    for bad_color_name in "${bad_color_list[@]}"; do
        if [ "$1" == "$bad_color_name" ]; then
            #echo "Bad color ==> $1"
            ret=1
            break
        fi
    done

    return $ret
}

declare -a color_list

function create_color_list ()
{
    local counter=${#color_list[@]}
    local vim_dir=$1

    echo "Color file path: $vim_dir" >&2
    echo "color_list has $counter items" >&2

    for ii in $vim_dir/*.vim; do
        if [ -f $ii ]; then
            color_name=$(basename "$ii" .vim)
            if use_this_color $color_name; then
                color_list[$counter]=$color_name
                counter=`expr $counter + 1`
            fi
        fi
    done
}

version_num=$(gvim --version | head -n 1 | cut -d ' ' -f 5 | tr -d '.')

create_color_list "/usr/share/vim/vim${version_num}/colors"
create_color_list "$HOME/.vim/colors"

color_count="${#color_list[*]}"

if [ $color_count -eq 0 ]; then
    echo "Error: There should at least be one available colour" >&2
    exit 1
fi

# Generate a random number within that range
random=$((RANDOM % $color_count))

if [ $random -gt $color_count ]; then
    echo "Error: $random should not exceed $color_count" >&2
    exit 1
fi

# Return the colour based on the random number
echo "${color_list[$random]}"

