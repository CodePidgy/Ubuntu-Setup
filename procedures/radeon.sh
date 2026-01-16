#!/bin/bash

echo "[INFO] Downloading driver..."

mkdir -p ~/Downloads

FILE=$(wget -q -O - https://repo.radeon.com/amdgpu-install/latest/ubuntu/noble/ | grep 'amdgpu-install_.*_all\.deb' | sed -n 's/.*href="\(amdgpu-install_[^"]*\.deb\)".*/\1/p' | head -n 1)

if [ -z "$FILE" ]; then
    echo "[ERROR] Could not find file"
    exit 1
fi

wget -O ~/Downloads/"$FILE" https://repo.radeon.com/amdgpu-install/latest/ubuntu/noble/"$FILE"

echo "[INFO] Installing driver..."
sudo apt install -y ~/Downloads/"$FILE"

echo "[INFO] Running amdgpu-install..."
sudo amdgpu-install -y

echo "[INFO] Installing btop fix..."
sudo apt install -y rocm-smi

echo "[INFO] Cleaning up..."
rm -f ~/Downloads/"$FILE"

echo "[INFO] Done"

