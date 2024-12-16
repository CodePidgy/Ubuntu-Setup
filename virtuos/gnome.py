# system imports --------------------------------------------------------------------------------- #
import json
import os
import subprocess


# methods ---------------------------------------------------------------------------------------- #
def extract_setting(obj, current_path=""):
    if isinstance(obj, dict):
        # Check for '_' key to handle value at the parent path
        if "_" in obj:
            # The key is the current key, path is the parent path
            key = current_path.split(".")[-1] if current_path else ""
            parent_path = ".".join(current_path.split(".")[:-1]) if "." in current_path else ""
            yield parent_path, key, obj["_"]

        # Traverse the remaining keys
        for key, value in obj.items():
            if key == "_":
                continue  # Skip the '_' key as it's already processed

            new_path = f"{current_path}.{key}" if current_path else key
            yield from extract_setting(value, new_path)
    else:
        # The value is at the leaf node, key is the last part of the path
        key = current_path.split(".")[-1]
        parent_path = ".".join(current_path.split(".")[:-1])

        if isinstance(obj, bool):
            obj = "true" if obj else "false"
        elif isinstance(obj, list) or isinstance(obj, str):
            obj = f'"{obj}"'

        yield parent_path, key, obj


def install_extension(id):
    print("Fetching extension metadata", end="")

    metadata = json.loads(
        subprocess.check_output(
            ["curl", "-s", f"https://extensions.gnome.org/extension-info/?pk={id}"],
        )
    )

    print(".", end="")

    uuid = metadata["uuid"].replace("@", "")
    name = metadata["name"]

    print("..", end="")

    latest_shell_version = 46
    latest_extension_version = metadata["shell_version_map"][str(latest_shell_version)]["version"]

    print("\tDone")

    file = f"{uuid}.v{latest_extension_version}.shell-extension.zip"
    url = f"https://extensions.gnome.org/extension-data/{file}"

    print(f"Downloading {file}...", end="")

    subprocess.call(
        ["wget", "-P", "/tmp", url],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

    print("\tDone")

    print(f"Installing {name}...", end="")

    subprocess.call(["gnome-extensions", "install", f"/tmp/{file}"])

    print("\tDone")

    print(f"Removing {file}...", end="")

    os.remove(f"/tmp/{file}")

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

for path, key, value in extract_setting(json.load(open("virtuos/data/dconf.json"))):
    os.system(f"gsettings set {path} {key} {value}")

    print(f"gsettings set {path} {key} {value}\n")
