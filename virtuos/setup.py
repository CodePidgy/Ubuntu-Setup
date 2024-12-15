# system imports --------------------------------------------------------------------------------- #
import os


cli = ["btop", "curl", "eza", "fzf", "git", "neofetch", "net-tools", "rar", "unrar", "unzip", "zip"]
desktop = ["gparted"]

for app in cli + desktop:
    os.system(f"sudo apt install -y {app}")
