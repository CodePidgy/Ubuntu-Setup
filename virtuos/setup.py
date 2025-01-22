# system imports --------------------------------------------------------------------------------- #
import os

# local imports ---------------------------------------------------------------------------------- #
from utils import print_heading, print_subheading

# script ----------------------------------------------------------------------------------------- #
print_heading("System")
os.system("python3 virtuos/system.py")
print_heading("User")
os.system("python3 virtuos/user.py")
print_heading("Terminal")
os.system("python3 virtuos/terminal.py")
print_heading("Python")
os.system("python3 virtuos/python.py")
print_heading("Dotfiles")
os.system("python3 virtuos/dotfiles.py")
print_heading("GNOME")
os.system("python3 virtuos/extensions.py")
print_heading("Apps")
print_subheading("Snap")
os.system("python3 virtuos/apps/snap.py")
