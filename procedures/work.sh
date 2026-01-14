#!/bin/bash

# Disable sleep on lid close
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

# Enable wake on USB
sudo touch /etc/udev/rules.d/10-wakeup.rules
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{3434}=="c548", ATTRS{d027}=="8120", ATTR{power/wakeup}="enabled"' | sudo tee -a /etc/udev/rules.d/10-wakeup.rules
sudo udevadm control --reload-rules
