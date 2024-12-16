# system imports --------------------------------------------------------------------------------- #
import json
import os


def extract_data(obj, current_path=""):
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
            yield from extract_data(value, new_path)
    else:
        # The value is at the leaf node, key is the last part of the path
        key = current_path.split(".")[-1]
        parent_path = ".".join(current_path.split(".")[:-1])

        if isinstance(obj, bool):
            obj = "true" if obj else "false"
        elif isinstance(obj, list) or isinstance(obj, str):
            obj = f'"{obj}"'

        yield parent_path, key, obj


with open("virtuos/data/dconf.json", "r") as file:
    settings = json.load(file)

for path, key, value in extract_data(settings):
    os.system(f"gsettings set {path} {key} {value}")
    print(f"gsettings set {path} {key} {value}\n")
