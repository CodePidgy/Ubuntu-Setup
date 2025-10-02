#!/bin/bash

echo "[INFO] Installing Steam..."
sudo snap install steam

echo "[INFO] Adding 32-bit architecture..."
sudo dpkg --add-architecture i386
sudo apt update

echo "[INFO] Finding NVIDIA driver version..."
NVIDIA_VERSION=$(apt list --installed | grep libnvidia-gl- | head -1 | sed 's/.*libnvidia-gl-\([0-9]*\)\/.*/\1/')

if [ -n "$NVIDIA_VERSION" ]; then
    echo "[INFO] NVIDIA driver version: $NVIDIA_VERSION"
    echo "[INFO] Installing NVIDIA drivers..."
    sudo apt install -y "libnvidia-gl-${NVIDIA_VERSION}:i386"
else
    echo "[ERROR] Unable to find NVIDIA driver version"
fi
