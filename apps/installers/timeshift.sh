#!/bin/bash

# Add Docker repository
sudo add-apt-repository -y ppa:teejee2008/timeshift
sudo apt update

# Install Timeshift
sudo apt install -y timeshift
