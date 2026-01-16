#!/bin/bash

echo "[INFO] Installing dependencies..."
sudo apt install -y dkms libdrm-dev

echo "[INFO] Adding DisplayLink repository..."
wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb -O $HOME/Downloads/synaptics-repository-keyring.deb
sudo apt install -y $HOME/Downloads/synaptics-repository-keyring.deb

echo "[INFO] Updating package lists..."
sudo apt update

echo "[INFO] Installing DisplayLink..."
sudo apt install -y displaylink-driver

echo "[INFO] Done"
