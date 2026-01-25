#!/usr/bin/env bash

# Default values
PREFIX="Dai"
START=1
DRY_RUN=false
DIR="."

show_help() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo
    echo "Options:"
    echo "  -p, --prefix STR    Set the naming prefix (default: Dai)"
    echo "  -s, --start NUM     Set the starting number (default: 1)"
    echo "  -d, --dry-run       Show what would happen without renaming"
    echo "  -h, --help          Show this help message"
    echo
    echo "Example:"
    echo "  $(basename "$0") --prefix Vacation --start 10 --dry-run"
}

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--prefix)  PREFIX="$2"; shift ;;
        -s|--start)   START="$2"; shift ;;
        -d|--dry-run) DRY_RUN=true ;;
        -h|--help)    show_help; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; show_help; exit 1 ;;
    esac
    shift
done

# Logic for execution mode
EXEC_CMD="bash"
if [ "$DRY_RUN" = true ]; then
    echo "--- DRY RUN: No files will be modified ---"
    EXEC_CMD="cat"
fi

# Find, sort, and rename
find "$DIR" -maxdepth 1 -type f -name 'Screenshot *.png' | \
  sed -E 's|.*/Screenshot ([0-9]{4})-([0-9]{2})-([0-9]{2}) at ([0-9]{2})\.([0-9]{2})\.([0-9]{2})\.png|\1\2\3\4\5\6 &|' | \
  sort | \
  cut -d' ' -f2- | \
  awk -v dir="$DIR" -v prefix="$PREFIX" -v start="$START" 'BEGIN { count=start }
  {
    ext = substr($0, length($0)-3)
    newname = sprintf("%s_%03d%s", prefix, count++, ext)
    printf "mv \"%s\" \"%s/%s\"\n", $0, dir, newname
  }' | $EXEC_CMD
