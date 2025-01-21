# system imports --------------------------------------------------------------------------------- #
import subprocess

# local imports ---------------------------------------------------------------------------------- #
from ..utils import print_subheading

# script ----------------------------------------------------------------------------------------- #
print_subheading("Update")
subprocess.call(["sudo", "apt", "update"])
subprocess.call(["sudo", "apt", "upgrade", "-y"])
subprocess.call(["sudo", "apt", "autoremove", "-y"])

print_subheading("System Apps")
desktop = ["dconf-editor", "gnome-shell-extension-manager", "gnome-tweaks", "gparted"]
subprocess.call(["sudo", "apt", "install", "-y"] + desktop)
