#!/bin/bash

echo "[INFO] Finding latest version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
echo "[INFO] Docker Compose version: $LATEST_VERSION"

echo "[INFO] Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/$LATEST_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

echo "[INFO] Adding Docker Desktop repository..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "[INFO] Installing Docker Desktop..."
wget -P $HOME/Downloads https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
sudo apt install -y $HOME/Downloads/docker-desktop-amd64.deb

echo "[INFO] Installing extras..."
sudo apt install -y docker-ce

echo "[INFO] Cleaning up..."
rm -f $HOME/Downloads/docker-desktop-amd64.deb

echo "[INFO] Addomg user to docker group..."
sudo groupadd docker
sudo usermod -a -G docker $USER
newgrp docker

echo "[INFO] Done"
