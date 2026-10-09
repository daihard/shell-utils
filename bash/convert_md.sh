#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") [--print [--double-sided]] <file.md>" >&2
    exit 1
}

DO_PRINT=false
SIDES_OPT="one-sided"
DOUBLE_SIDED_SET=false
INPUT_MD=""

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        --print)
            DO_PRINT=true
            shift
            ;;
        --double-sided)
            DOUBLE_SIDED_SET=true
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

# Validate option dependencies
if [ "$DOUBLE_SIDED_SET" = true ] && [ "$DO_PRINT" = false ]; then
    echo "Error: --double-sided can only be specified when --print is also present." >&2
    usage
fi

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
pandoc "$INPUT_MD" -o "$OUTPUT_PDF" --pdf-engine=typst \
  -V fontsize=14pt \
  -V papersize=us-letter \
  --metadata-file=<(printf 'margin:\n  x: 1in\n  y: 0.5in\n')

echo "Generated: $OUTPUT_PDF"

# Print only when requested
if [ "$DO_PRINT" = true ]; then
    lp -o "sides=${SIDES_OPT}" "$OUTPUT_PDF"
    echo "Sent to printer (${SIDES_OPT})."
fi



