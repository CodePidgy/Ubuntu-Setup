# system imports --------------------------------------------------------------------------------- #
import json
import os
import subprocess


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


def print_heading(text, level):
    terminal_width = os.get_terminal_size().columns - (len(text) + 2)
    segment = "=" if level == 1 else "-" if level == 2 else "-"
    left = "".join([segment for _ in range(terminal_width // 2)])
    right = "".join([segment for _ in range(terminal_width // 2)])

    if terminal_width % 2 != 0:
        right += segment

    print(f"{left} {text} {right}")


# scripts ---------------------------------------------------------------------------------------- #
print_heading("GNOME", 1)

extensions = [
    7,  # Drive Menu
    1160,  # Dash to Panel
    3193,  # Blur My Shell
    3843,  # Just Perfection
    5547,  # Custom Accent Colors
    6682,  # Astra Monitor
]

print_heading("Extensions", 2)

for extension in extensions:
    install_extension(extension)

    print()

print_heading("DCONF", 2)

os.system("dconf load / < data/system.ini")
os.system("dconf load / < data/extensions.ini")
