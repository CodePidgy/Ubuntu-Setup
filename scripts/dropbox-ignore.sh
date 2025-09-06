#!/bin/bash

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No path provided"
    echo "Usage: dropbox-ignore <path>"
    exit 1
fi

# Get the path argument
TARGET_PATH="$1"

# Check if the path exists
if [ ! -e "$TARGET_PATH" ]; then
    echo "Error: Path '$TARGET_PATH' does not exist"
    exit 1
fi

# Convert to absolute path if it's relative
if [[ "$TARGET_PATH" != /* ]]; then
    TARGET_PATH="$(realpath "$TARGET_PATH")"
fi

echo "Setting Dropbox ignore attribute for: $TARGET_PATH"

# Set the Dropbox ignore attribute
if attr -s com.dropbox.ignored -V 1 "$TARGET_PATH" 2>/dev/null; then
    echo "Successfully set ignore attribute for: $TARGET_PATH"
else
    echo "Error: Failed to set ignore attribute for: $TARGET_PATH"
    exit 1
fi
