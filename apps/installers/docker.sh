#!/bin/bash

echo "[INFO] Adding Docker repository..."
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

echo "[INFO] Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[INFO] Cleaning up..."
rm -f $HOME/Downloads/docker-desktop-amd64.deb

echo "[INFO] Addomg user to docker group..."
sudo groupadd docker
sudo usermod -a -G docker $USER
newgrp docker

echo "[INFO] Done"
