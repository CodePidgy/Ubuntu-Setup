#!/bin/bash

# Find the .deb file
FILE=$(find $HOME/Downloads -type f -regextype posix-extended -regex ".*/cursor_[0-9]+\.[0-9]+\.[0-9]+_amd64\.deb" | head -n 1)

# Check if the file was found
if [[ -z "$FILE" ]]; then
    echo "No matching .deb file found in $dir"
    exit 1
fi

# Install Cursor
sudo apt install -y $FILE
