#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") [--double-sided] <file.md>" >&2
    exit 1
}

# Default to single-sided printing
SIDES_OPT="one-sided"
INPUT_MD=""

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        --double-sided)
            SIDES_OPT="two-sided-long-edge"
            shift
            ;;
        -h|--help)
            usage
            ;;
        -*)
            echo "Unknown option: $1" >&2
            usage
            ;;
        *)
            if [ -n "$INPUT_MD" ]; then
                echo "Error: Only one Markdown file may be specified." >&2
                usage
            fi
            INPUT_MD="$1"
            shift
            ;;
    esac
done

if [ -z "$INPUT_MD" ]; then
    echo "Error: No Markdown file provided." >&2
    usage
fi

if [ ! -f "$INPUT_MD" ]; then
    echo "Error: File '$INPUT_MD' not found." >&2
    exit 1
fi

OUTPUT_PDF="${INPUT_MD%.*}.pdf"

# Convert markdown directly to PDF via Typst engine
pandoc "$INPUT_MD" -o "$OUTPUT_PDF" --pdf-engine=typst -V fontsize=14pt

pandoc "$INPUT_MD" -o "$OUTPUT_PDF" --pdf-engine=typst \
  -V fontsize=14pt \
  -V papersize=us-letter \
  --metadata-file=<(printf 'margin:\n  x: 1in\n  y: 0.5in\n')

# Print using macOS native lp utility
lp -o "sides=${SIDES_OPT}" "$OUTPUT_PDF"

