#!/bin/bash

echo "[INFO] Adding repository..."
sudo add-apt-repository ppa:jurkovic-nikola/openlinkhub
sudo apt update

echo "[INFO] Installing OpenLinkHub..."
sudo apt install -y openlinkhub

echo "[INFO] Starting service..."
sudo systemctl start OpenLinkHub.service

echo "[INFO] Done"
