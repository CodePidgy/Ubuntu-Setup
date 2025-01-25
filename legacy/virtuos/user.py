# system imports --------------------------------------------------------------------------------- #
import os

# script ----------------------------------------------------------------------------------------- #
print("Setting profile picture.", end="")
os.system("sudo rm -f /var/lib/AccountsService/icons/aidan")
print(".", end="")
os.system("sudo cp images/profile.png /var/lib/AccountsService/icons/aidan")
print(".\tDone")

print("Setting wallpaper.", end="")
os.system("mkdir $HOME/Pictures/Wallpapers")
print(".", end="")
os.system("cp images/bg-light.svg $HOME/Pictures/Wallpapers/")
print(".", end="")
os.system("cp images/bg-dark.svg $HOME/Pictures/Wallpapers/")
print("\tDone")
