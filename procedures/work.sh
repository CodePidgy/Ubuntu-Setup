#!/bin/bash

# https://askubuntu.com/questions/1443640/disable-laptop-keyboard-on-demand-in-wayland

echo "[INFO] Installing libinput..."
sudo apt install -y libinput-tools

echo "[INFO] Adding keyboard-override command..."
sudo ln -s $HOME/setup/scripts/keyboard-override.sh /usr/local/bin/keyboard-override
