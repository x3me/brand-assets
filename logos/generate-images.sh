#!/bin/bash

set -e

# check if imagemagick exists
if ! command -v magick &>/dev/null; then
    echo "ImageMagick is not installed. Please install it first."
    exit 1
fi

sizes=(1024 512 72 28)

# Find all SVG files and process them
while IFS= read -r svg_file; do
    # Remove .svg extension to get the base name
    source="${svg_file%.svg}"

    rm -f ${source}-*.png ${source}-*.webp
    for size in "${sizes[@]}"; do
        magick -background none -density 300 ${svg_file} -resize x${size} ${source}-${size}.png
    done
    mogrify -format webp -quality 80 ${source}-*.png
done < <(find . -name "*.svg" -type f)
