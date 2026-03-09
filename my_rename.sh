#!/usr/bin/env bash

# Default values
PREFIX="Dai"
START=1
DRY_RUN=false
ORDER="al"
DIR="."

show_help() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo
    echo "Renames visible files in the directory based on specified order."
    echo
    echo "Options:"
    echo "  -p, --prefix STR    Set the naming prefix (default: Dai)"
    echo "  -s, --start NUM     Set the starting number (default: 1)"
    echo "  -o, --order [al|ch] Sorting order: 'al' (alphanumeric) or 'ch' (chronological)"
    echo "                      (default: al)"
    echo "  -d, --dry-run       Show what would happen without renaming"
    echo "  -h, --help          Show this help message"
}

# Parse named arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--prefix)  PREFIX="$2"; shift ;;
        -s|--start)   START="$2"; shift ;;
        -o|--order)   ORDER="$2"; shift ;;
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

# Logic Branching based on Order
if [[ "$ORDER" == "ch" ]]; then
    # Chronological: Need stat to get timestamps
    if [[ "$OSTYPE" == "darwin"* ]]; then
        STAT_EXEC='stat -f "%m %N" "$@"' # macOS/BSD
    else
        STAT_EXEC='stat -c "%Y %n" "$@"' # Linux/GNU
    fi
    # Find -> Stat -> Sort Numerically -> Strip Timestamp
    LIST_CMD="find \"$DIR\" -maxdepth 1 -type f ! -name \".*\" ! -name \"$(basename "$0")\" -exec sh -c '$STAT_EXEC' sh {} + | sort -n | cut -d' ' -f2-"
else
    # Alphanumeric: Standard find and sort
    LIST_CMD="find \"$DIR\" -maxdepth 1 -type f ! -name \".*\" ! -name \"$(basename "$0")\" | sort"
fi

# Execute the determined list command and pipe to awk for renaming
eval "$LIST_CMD" | awk -v dir="$DIR" -v prefix="$PREFIX" -v start="$START" 'BEGIN { count=start }
{
    # Find the last dot to extract extension
    match($0, /\.[^.]+$/)
    ext = (RSTART > 0) ? substr($0, RSTART) : ""

    newname = sprintf("%s_%03d%s", prefix, count++, ext)
    printf "mv \"%s\" \"%s/%s\"\n", $0, dir, newname
}' | $EXEC_CMD

