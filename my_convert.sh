#!/bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#ext="jpg"
title=some_magazine

outdir=~/Documents/books/

# Override the output directory if set by an enrivonment var
if [ "$MY_CONVERT_OUTDIR" != "" ]; then
    outdir=$MY_CONVERT_OUTDIR
fi

declare -a ext_list=("jpg" "jpeg" "png" "JPG" "JPEG" "PNG")

while [ $# -gt 1 ]; do
    case "$1" in
        --title)
            title=$2
            shift
            ;;
        --outdir)
            outdir=$2
            shift
            ;;
        *)
            shift
            ;;
    esac
done

echo "Outputting to $outdir..."

for ext in ${ext_list[@]}; do 
    found_file=$(find . -type f -name "*.${ext}")
    if [[ "$found_file" != "" ]]; then
        ## Convert each image file to a pdf
        for f in $(ls -v *.${ext}); do
            convert -quality 100 ./"$f" -density 300 ./"${f%.${ext}}.pdf"
        done
    fi
done

## Combine all the pdf files into one big pdf
pdftk $(ls -v *.pdf) cat output $title.pdf && mv $title.pdf ${outdir}

unset ext
unset ext_list
unset title
unset outdir

IFS=$SAVEIFS
