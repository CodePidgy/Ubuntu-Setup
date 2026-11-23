#!/bin/bash

if [ -z "$1" ]; then
    echo "[ERROR] Usage: $0 <path to winboat-backup.tar.zst>"
    exit 1
fi

if ! docker info > /dev/null 2>&1; then
    echo "[ERROR] Cannot reach Docker. Is it installed and running, and is your session in the docker group (log out and back in)?"
    exit 1
fi

if [ -e $HOME/winboat ] || [ -e $HOME/.winboat ]; then
    echo "[ERROR] $HOME/winboat or $HOME/.winboat already exists, remove them first"
    exit 1
fi

echo "[INFO] Extracting archive..."
tar -I zstd -xSpf "$1" -C $HOME || exit 1

echo "[INFO] Composing container..."
docker compose -f ~/.winboat/docker-compose.yml up --no-start || exit 1

echo "[INFO] Done"
