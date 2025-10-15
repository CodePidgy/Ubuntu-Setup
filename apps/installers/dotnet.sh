#!/bin/bash

# Setup key and repo
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Install
sudo apt update
sudo apt install -y dotnet-sdk-9.0 dotnet-sdk-8.0 aspnetcore-runtime-9.0 aspnetcore-runtime-8.0
