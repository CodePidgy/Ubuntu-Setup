# system imports --------------------------------------------------------------------------------- #
import os

# local imports ---------------------------------------------------------------------------------- #
from utils import print_subheading

# script ----------------------------------------------------------------------------------------- #
print_subheading("CLI Tools")
cli = [
    "btop",
    "curl",
    "eza",
    "fzf",
    "git",
    "neofetch",
    "net-tools",
    "rar",
    "stow",
    "unrar",
    "unzip",
    "zip",
    "zsh",
]
os.system(f"sudo apt install -y {' '.join(cli)}")

print("Removing app shortcuts...", end="")
os.system("sudo rm -f /usr/share/applications/btop.desktop")
print("\tDone")
