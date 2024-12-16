# system imports --------------------------------------------------------------------------------- #
import os

os.system("sudo apt update")

desktop = ["dconf-editor", "gnome-shell-extension-manager", "gnome-tweaks", "gparted"]

os.system(f"sudo apt install -y {' '.join(desktop)}")
