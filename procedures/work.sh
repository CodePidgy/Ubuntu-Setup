#!/bin/bash

# Disable sleep on lid close
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

# Enable wake on USB
sudo touch /etc/udev/rules.d/10-wakeup.rules
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{046d}=="c548", ATTRS{c52b}=="8120", ATTR{power/wakeup}="enabled"' | sudo tee /etc/udev/rules.d/10-wakeup.rules # Logitech MX Master 4, Vendor ID: 046d, Product ID: c548
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{3434}=="c548", ATTRS{d027}=="8120", ATTR{power/wakeup}="enabled"' | sudo tee -a /etc/udev/rules.d/10-wakeup.rules # Keychron B9 Pro, Vendor ID: 3434, Product ID: d027
sudo udevadm control --reload-rules
