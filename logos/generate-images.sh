#!/bin/bash

set -e

# check if inkscape exists
if ! command -v inkscape &>/dev/null; then
    echo "Inkscape is not installed. Please install it first."
    exit 1
fi

sources=(
    "extreme-exchange/logo-orange"
    "extreme-labs/logo-black"
    "extreme-labs/logo-icon"
    "extreme-labs/logo-orange"
    "extreme-labs/logo-white"
)
sizes=(1024 512 72 28)

for source in "${sources[@]}"; do
    rm -f ${source}-*.png ${source}-*.webp
    for size in "${sizes[@]}"; do
        inkscape -h ${size} ${source}.svg -o ${source}-${size}.png
    done
    mogrify -format webp -quality 80 ${source}-*.png
done
