# system imports --------------------------------------------------------------------------------- #
import os

# local imports ---------------------------------------------------------------------------------- #
from utils import print_subheading

# script ----------------------------------------------------------------------------------------- #
print_subheading("Update")
os.system("sudo apt update")
os.system("sudo apt upgrade -y")
os.system("sudo apt autoremove -y")
os.system("sudo systemctl daemon-reload")

print_subheading("System Apps")
apps = ["dconf-editor", "gnome-shell-extension-manager", "gnome-tweaks"]
os.system("sudo apt install -y " + " ".join(apps))

print("Loading DCONF...", end="")
os.system("dconf load / < data/system.ini")
print("\tDone")
