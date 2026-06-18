#!/bin/bash

echo "[INFO] Installing..."
flatpak install -y com.yubico.yubioath

echo "[INFO] Setting up..."
sudo apt install -y pcscd

echo "[INFO] Done"
