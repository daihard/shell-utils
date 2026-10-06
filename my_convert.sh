#!/usr/bin/env bash

title="some_magazine"
outdir=~/Documents/books/

# Override the output directory if set by an environment var
if [ -n "$MY_CONVERT_OUTDIR" ]; then
    outdir="$MY_CONVERT_OUTDIR"
fi

while [ $# -gt 0 ]; do
    case "$1" in
        --title)
            title="$2"
            shift 2
            ;;
        --outdir)
            outdir="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Prefer ImageMagick 7's 'magick', fall back to ImageMagick 6's 'convert'
if command -v magick >/dev/null 2>&1; then
    MAGICK_CMD="magick"
elif command -v convert >/dev/null 2>&1; then
    MAGICK_CMD="convert"
else
    echo "Error: ImageMagick (magick or convert) is not installed." >&2
    exit 1
fi

echo "$MAGICK_CMD outputting to $outdir..."

# Ensure target directory exists
mkdir -p "$outdir"

# Enable nullglob and case-insensitive matching for extensions
shopt -s nullglob nocaseglob
ext_list=("jpg" "jpeg" "png" "webp")

for ext in "${ext_list[@]}"; do
    for f in *."${ext}"; do
        [ -e "${f}" ] || continue
        "${MAGICK_CMD}" -density 300 ./"${f}" -quality 100 ./"${f%.*}.pdf"
    done
done
shopt -u nocaseglob

## Combine all the pdf files into one big pdf
pdf_files=( *.pdf )
shopt -u nullglob

if (( ${#pdf_files[@]} > 0 )); then
    pdftk "${pdf_files[@]}" cat output "$title.pdf" && mv "$title.pdf" "$outdir"
fi

unset ext
unset ext_list
unset title
unset outdir

