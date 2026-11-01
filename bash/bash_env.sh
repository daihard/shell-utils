#!/usr/bin/env bash
# vim: set filetype=sh:
#
# bash_env.sh
# -----------

if [ "$(uname -s)" = "Darwin" ]; then
    # brew install gawk
    awk() { gawk "$@"; }
    gvim() {
        # Launch MacVim in the background
        /Applications/MacVim.app/Contents/MacOS/Vim -g "$@" &
    }
    realpath() { grealpath "$@"; }
    objdump() { /opt/homebrew/opt/binutils/bin/gobjdump "$@"; }
    tar() { gtar "$@"; }

    heic2jpg() {
        magick "$1" -auto-orient -quality 100 -sampling-factor 4:4:4 "${1%.*}.jpg"
    }
fi

# Strips metadata but restores orientation and color profile
strip_metadata() {
    exiftool -P -overwrite_original -all:all= -APP11:all= -tagsFromFile @ -Orientation -ColorSpace -icc_profile "$@"
}

