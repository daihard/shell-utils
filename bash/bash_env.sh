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

    mdvw() {
        local target_file=""
        if [ -n "$1" ]; then
            target_file="$(cd "$(dirname "$1")" 2>/dev/null && pwd)/$(basename "$1")"
        fi

        osascript -e 'on run argv' \
                  -e '  set filePath to item 1 of argv' \
                  -e '  tell application "iTerm2"' \
                  -e '    create window with default profile' \
                  -e '    tell current session of current window' \
                  -e '      write text "mdv " & quoted form of filePath & "; exit"' \
                  -e '    end tell' \
                  -e '  end tell' \
                  -e 'end run' -- "$target_file"
    }
fi

# Strips metadata but restores orientation and color profile
strip_metadata() {
    exiftool -P -overwrite_original -all:all= -APP11:all= -tagsFromFile @ -Orientation -ColorSpace -icc_profile "$@"
}

