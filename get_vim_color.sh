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

declare -a color_list

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

# Generate a random number within that range
random=`expr $RANDOM % $color_count`

if [ $random -gt $color_count ]; then
    echo "Error: $random should not exceed $color_count"
    exit 1
fi

# Return the colour based on the random number
echo "${color_list[$random]}"

