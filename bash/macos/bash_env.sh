#!/usr/bin/env bash
# vim: set filetype=sh:
#
# macos_env.sh

# Fail if this file is used on a non-macOS platform
[ "$(uname -s)" = "Darwin" ] || { echo "macOS required" >&2; exit 1; }

# Launch MacVim in the background
gvim() { /Applications/MacVim.app/Contents/MacOS/Vim -g "$@" & }

realpath() { grealpath "$@"; }
