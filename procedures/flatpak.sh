#!/bin/bash

echo "[INFO] Installing Flatpak..."
sudo apt install -y flatpak

echo "[INFO] Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "[INFO] Done"
