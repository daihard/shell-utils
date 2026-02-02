#!/usr/bin/env bash

# Default values
PREFIX="Dai"
START=1
DRY_RUN=false
DIR="."

show_help() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo
    echo "Renames all visible files in the directory chronologically (Oldest -> Newest)."
    echo "Works on both macOS (BSD) and Linux (GNU)."
    echo
    echo "Options:"
    echo "  -p, --prefix STR    Set the naming prefix (default: Dai)"
    echo "  -s, --start NUM     Set the starting number (default: 1)"
    echo "  -d, --dry-run       Show what would happen without renaming"
    echo "  -h, --help          Show this help message"
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

EXEC_CMD="bash"
if [ "$DRY_RUN" = true ]; then
    echo "--- DRY RUN: No files will be modified ---"
    EXEC_CMD="cat"
fi

# Detect OS to handle stat flags
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS / BSD
    FIND_EXEC='stat -f "%m %N" "$@"'
else
    # Linux / GNU
    FIND_EXEC='stat -c "%Y %n" "$@"'
fi

# 1. find: Look for visible files
# 2. sh -c: Passes the files ($@) to the correct stat version
# 3. sort -n: Sorts by Unix timestamp
# 4. awk: Handles renaming logic
find "$DIR" -maxdepth 1 -type f ! -name ".*" ! -name "$(basename "$0")" \
    -exec sh -c "$FIND_EXEC" sh {} + | \
    sort -n | \
    cut -d' ' -f2- | \
    awk -v dir="$DIR" -v prefix="$PREFIX" -v start="$START" 'BEGIN { count=start }
    {
        # Find the last dot to extract extension
        match($0, /\.[^.]+$/)
        ext = (RSTART > 0) ? substr($0, RSTART) : ""
        
        newname = sprintf("%s_%03d%s", prefix, count++, ext)
        printf "mv \"%s\" \"%s/%s\"\n", $0, dir, newname
    }' | $EXEC_CMD
