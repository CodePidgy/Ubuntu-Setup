#!/bin/bash

# Set profile picture
sudo rm -f /var/lib/AccountsService/icons/$USER
sudo cp images/profile.png /var/lib/AccountsService/icons/$USER
sudo sed -i "s/Icon=\/home\/aidan\/.face/Icon=\/var\/lib\/AccountsService\/icons\/aidan/" /var/lib/AccountsService/users/aidan

# Set wallpaper
mkdir $HOME/Pictures/Wallpapers
cp images/bg-light.svg $HOME/Pictures/Wallpapers/
cp images/bg-dark.svg $HOME/Pictures/Wallpapers/
