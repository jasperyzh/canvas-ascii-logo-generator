#!/bin/bash

# Get list of fonts and process them
ascii-logo list-fonts | grep -E '^- ' | sed 's/^- //' | while read -r font; do
    # Use the font name as the text content
    TEXT="$font"
    
    # Sanitize font name for filename
    filename=$(echo "$font" | \
                tr ' ' '_' | \
                tr -d "'" | \
                tr -d "()" | \
                tr -d "." | \
                sed 's/&/and/g' | \
                sed 's/+/plus/g')
    
    # Generate SVG for each font
    echo "Generating: $font => $filename.svg"
    ascii-logo generate "$TEXT" --font "$font" --svg --color "#000000" --background "none" --width 1000 --output "$filename.svg"
done

echo "All fonts generated!"
