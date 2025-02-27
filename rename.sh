#!/bin/bash

IFS='_'
counter=0

declare -a ext_list=("jpg" "jpeg" "png" "JPG" "JPEG" "PNG")

for ext in ${ext_list[@]}; do 
    found_file=$(find . -type f -name "*.${ext}")
    if [[ "$found_file" != "" ]]; then
        ## Convert each image file to a pdf
        for f in $(ls -v *.${ext}); do
            counter=0
            for word in $f; do
                counter=`expr $counter + 1`
                echo $counter $word;
                ##if [ $counter -gt 1 ]; then
                ##    echo "$word";
                ## fi
            done
##counter=0
        done
    fi
done

## for f in $(ls -v *.${ext}); do
##     counter=`expr $counter + 1`
## ##mv ./"$f" "$(printf "%0004d" $counter).jpg"
##     echo "$f"
## done

