#!/bin/bash

if [ -z "$1" ]; then
    echo "[ERROR] Usage: $0 <destination directory>"
    exit 1
fi

ARCHIVE="$1/winboat-backup.tar.zst"

echo "[INFO] Stopping Winboat..."
docker stop -t 120 WinBoat

echo "[INFO] Creating archive at $ARCHIVE..."
tar -I 'zstd -T0' -cSpf "$ARCHIVE" -C $HOME winboat .winboat || exit 1

echo "[INFO] Verifying archive..."
tar -I zstd -tf "$ARCHIVE" > /dev/null || exit 1

echo "[INFO] Done"
