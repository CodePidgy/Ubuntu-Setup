# system imports --------------------------------------------------------------------------------- #
import subprocess

subprocess.call(["sudo", "apt", "update"])
subprocess.call(["sudo", "apt", "upgrade", "-y"])

desktop = ["dconf-editor", "gnome-shell-extension-manager", "gnome-tweaks", "gparted"]

subprocess.call(["sudo", "apt", "install", "-y"] + desktop)
subprocess.call(["python3", "virtuos/terminal.py"])
subprocess.call(["stow", "-d", "dotfiles", "-t", "~/"])
subprocess.call(["python3", "virtuos/gnome.py"])
