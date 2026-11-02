#!/bin/bash

if [ -z "$1" ]; then
    echo "[ERROR] Usage: $0 <path to winboat-backup.tar.zst>"
    exit 1
fi

if [ -e $HOME/winboat ] || [ -e $HOME/.winboat ]; then
    echo "[ERROR] $HOME/winboat or $HOME/.winboat already exists, remove them first"
    exit 1
fi

echo "[INFO] Extracting archive..."
tar -I zstd -xSpf "$1" -C $HOME || exit 1

echo "[INFO] Done"
