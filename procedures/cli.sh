#!/bin/bash

echo "[INFO] Installing CLI tools..."
sudo apt install -y attr btop ca-certificates curl eza fzf rar stow tmux unrar unzip zsh
sudo rm -f /usr/share/applications/btop.desktop

echo "[INFO] Setting default shell..."
chsh -s /usr/bin/zsh

echo "[INFO] Done"
