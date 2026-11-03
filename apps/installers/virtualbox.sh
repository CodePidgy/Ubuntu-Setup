#!/bin/bash

echo "[INFO] Accepting extension pack license..."
echo virtualbox-ext-pack virtualbox-ext-pack/license select true | sudo debconf-set-selections

echo "[INFO] Installing VirtualBox..."
sudo apt install -y virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso

echo "[INFO] Adding user to vboxusers group..."
sudo usermod -a -G vboxusers $USER

echo "[INFO] Done"
