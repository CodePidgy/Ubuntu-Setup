#!/bin/bash

# Disable sleep on lid close
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

# Enable wake on USB
sudo touch /etc/udev/rules.d/10-wakeup.rules
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{046d}=="239a", ATTRS{c52b}=="8120", ATTR{power/wakeup}="enabled"' | sudo tee /etc/udev/rules.d/10-wakeup.rules
sudo udevadm control --reload-rules
