# system imports --------------------------------------------------------------------------------- #
import os


cli = ["btop", "curl", "eza", "fzf", "git", "neofetch", "net-tools", "rar", "unrar", "unzip", "zip"]
desktop = ["gparted"]

os.system(f"sudo apt install -y {' '.join(cli + desktop)}")
