#!/usr/bin/env bash

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

# Use 'find' instead of 'ls -v' so file names that include special characters
# (such as spaces) can be handled correctly
for ext in "${ext_list[@]}"; do
    find . -maxdepth 1 -name "*.${ext}" -print0 | sort -z -V | while IFS= read -r -d '' f; do
        clean_f="${f#./}"
        # echo "${clean_f}"
        convert -quality 100 ./"${clean_f}" -density 300 ./"${clean_f%."${ext}"}.pdf"
    done
done

## Combine all the pdf files into one big pdf
mapfile -d '' pdf_files < <(find . -type f -name "*.pdf" -print0 | sort -z -V)
pdftk "${pdf_files[@]}" cat output "$title".pdf && mv "$title".pdf "${outdir}"

unset ext
unset ext_list
unset title
unset outdir

