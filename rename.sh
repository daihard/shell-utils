#!/usr/bin/env bash

# Directory to scan (current directory by default)
DIR="."

# Use first argument as prefix, default to "Dai"
PREFIX="${1:-Dai}"

# Use second argument as starting number, default to 1
START="${2:-1}"

# Find matching files and sort them by timestamp extracted from filename
find "$DIR" -type f -name 'Screenshot *.png' | \
  sed -E 's|.*/Screenshot ([0-9]{4})-([0-9]{2})-([0-9]{2}) at ([0-9]{2})\.([0-9]{2})\.([0-9]{2})\.png|\1\2\3\4\5\6 &|' | \
  sort | \
  cut -d' ' -f2- | \
  awk -v dir="$DIR" -v prefix="$PREFIX" -v start="$START" 'BEGIN { count=start }
  {
    ext = substr($0, length($0)-3)
    newname = sprintf("%s_%03d%s", prefix, count++, ext)
    printf "mv \"%s\" \"%s/%s\"\n", $0, dir, newname
  }' | bash
