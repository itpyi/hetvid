#!/bin/sh
# Generate src/thumbnail.png from page 1 of doc/doc.typ.
# Run from the repo root.

set -e

typst compile doc/doc.typ src/thumbnail.png --pages 1 --ppi 250 --root .
echo "Thumbnail written to src/thumbnail.png"
