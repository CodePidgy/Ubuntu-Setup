# system imports --------------------------------------------------------------------------------- #
import json
import os
import subprocess

# local imports ---------------------------------------------------------------------------------- #
from utils import print_subheading


# methods ---------------------------------------------------------------------------------------- #
def install_extension(id):
    print("Fetching extension metadata", end="")

    metadata = json.loads(
        subprocess.check_output(
            ["curl", "-s", f"https://extensions.gnome.org/extension-info/?pk={id}"],
        )
    )

    print(".", end="")

    uuid = metadata["uuid"]
    name = metadata["name"]

    print("..", end="")

    latest_shell_version = 46
    latest_extension_version = metadata["shell_version_map"][str(latest_shell_version)]["version"]

    print("\tDone")

    file = f"{uuid.replace("@", "")}.v{latest_extension_version}.shell-extension.zip"
    url = f"https://extensions.gnome.org/extension-data/{file}"

    print("Checking cache...", end="")

    if not os.path.exists(f"/tmp/setup"):
        os.makedirs(f"/tmp/setup")
    else:
        if os.path.exists(f"/tmp/setup/{file}"):
            print("\tDone")
            print(f"{name} is already installed")
            return

    print("\tDone")
    print(f"Downloading {file}...", end="")

    subprocess.call(
        ["wget", "-P", "/tmp/setup", url],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    print("\tDone")
    print(f"Installing {name}...", end="")

    subprocess.call(
        ["gnome-extensions", "install", f"/tmp/setup/{file}"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    print("\tDone")


# script ----------------------------------------------------------------------------------------- #
print_subheading("Extensions")
extensions = [
    7,  # Drive Menu
    1160,  # Dash to Panel
    3193,  # Blur My Shell
    3843,  # Just Perfection
    5547,  # Custom Accent Colors
    6682,  # Astra Monitor
]
for extension in extensions:
    install_extension(extension)

    print()

print("Loading DCONF...", end="")
os.system("dconf load / < data/system.ini")
print("\tDone")
