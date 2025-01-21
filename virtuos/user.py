# system imports --------------------------------------------------------------------------------- #
import subprocess

# local imports ---------------------------------------------------------------------------------- #
from utils import print_subheading

# script ----------------------------------------------------------------------------------------- #
print("Setting profile picture.", end="")
subprocess.call(["rm", "-f", "/var/lib/AccountsService/icons/aidan"])
print(".", end="")
subprocess.call(["cp", "images/profile.png", "/var/lib/AccountsService/icons/aidan"])
print(".\tDone")

print("Setting wallpaper.", end="")
subprocess.call(["mkdir", "$HOME/Pictures/Wallpapers"])
print(".", end="")
subprocess.call(["cp", "images/bg-light.svg", "$HOME/Pictures/Wallpapers/"])
print(".", end="")
subprocess.call(["cp", "images/bg-dark.svg", "$HOME/Pictures/Wallpapers/"])
print("\tDone")
