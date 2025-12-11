#!/bin/bash

# Download Chrome
wget -P $HOME/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install Chrome
sudo apt install -y $HOME/Downloads/google-chrome-stable_current_amd64.deb
