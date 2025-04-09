#!/usr/bin/env bash
# vim: set filetype=sh:
#
# bash_env.sh
# -----------
# This file contains macOS-specific functions. Create a symlink (e.g.
# ~/.macos_bash_env) so .bashrc can use it easily.

# Fail if this file is used on a non-macOS platform
[ "$(uname -s)" = "Darwin" ] || { echo "macOS required" >&2; exit 1; }

# Launch MacVim in the background
gvim() { /Applications/MacVim.app/Contents/MacOS/Vim -g "$@" & }

realpath() { grealpath "$@"; }
