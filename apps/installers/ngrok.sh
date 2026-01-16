#!/bin/bash

echo "[INFO] Adding ngrok package repository..."
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" | sudo tee /etc/apt/sources.list.d/ngrok.list

echo "[INFO] Installing ngrok..."
sudo apt update
sudo apt install -y ngrok

echo "[INFO] Done"

# Notes
# Go to https://dashboard.ngrok.com/get-started/setup/linux to copy and run the auth token command
# Add "console_ui_color: transparent" to ~/.config/ngrok/ngrok.yml
