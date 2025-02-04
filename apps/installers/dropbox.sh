#!/bin/bash

url="https://www.dropbox.com/download?dl=packages/ubuntu"

# Find the newest version
file=$(
    curl -fsLS $url |
    grep -oP '(?<!")dropbox_[0-9]*.[0-9]*.[0-9]*_amd64.deb' |
    tail -n 1
)

# Download, install, and remove the file
wget $url/$file -O $HOME/Downloads/$file
sudo dpkg -i $HOME/Downloads/$file
rm -f $HOME/Downloads/$file

# Remove nautilus integration
sudo mv /usr/lib/x86_64-linux-gnu/nautilus/extensions-4/libnautilus-dropbox.so{,.bak}
