#!/bin/bash

# Download the extension
wget -P $HOME/Downloads https://github.com/Stunkymonkey/nautilus-open-any-terminal/releases/download/0.6.0/nautilus-extension-any-terminal_0.6.0-1_all.deb

# Install the extension
sudo apt install -y $HOME/Downloads/nautilus-extension-any-terminal_0.6.0-1_all.deb
