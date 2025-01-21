# system imports --------------------------------------------------------------------------------- #
import subprocess

# local imports ---------------------------------------------------------------------------------- #
from utils import print_heading

# script ----------------------------------------------------------------------------------------- #
print_heading("System")
subprocess.call(["python3", "virtuos/system.py"])
print_heading("User")
subprocess.call(["python3", "virtuos/user.py"])
print_heading("Terminal")
subprocess.call(["python3", "virtuos/terminal.py"])
print_heading("Dotfiles")
subprocess.call(["stow", "-d", "dotfiles", "-t", "$HOME", "."])
print_heading("GNOME")
subprocess.call(["python3", "virtuos/gnome.py"])
