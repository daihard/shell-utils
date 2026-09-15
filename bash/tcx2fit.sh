#!/usr/bin/env bash

set -euo pipefail

# Check for exactly two arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_file.tcx> <output_file.fit>" >&2
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

# Verify input file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: Input file '$INPUT_FILE' does not exist." >&2
  exit 1
fi

# Ensure gpsbabel is installed and available in PATH
if ! command -v gpsbabel >/dev/null 2>&1; then
  echo "Error: 'gpsbabel' command not found. Please install it first." >&2
  exit 1
fi

# Run conversion
gpsbabel -i gtrnctr -f "$INPUT_FILE" -o garmin_fit -F "$OUTPUT_FILE"

echo "Successfully converted '$INPUT_FILE' -> '$OUTPUT_FILE'"

