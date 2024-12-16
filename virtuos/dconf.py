# system imports --------------------------------------------------------------------------------- #
import json
import os


def extract_data(obj, current_path=""):
    if isinstance(obj, dict):
        for key, value in obj.items():
            new_path = f"{current_path}.{key}" if current_path else key

            yield from extract_data(value, new_path)
    else:
        yield ".".join(current_path.split(".")[:-1]), current_path.split(".")[-1], obj


with open("virtuos/data/dconf.json", "r") as file:
    settings = json.load(file)

for path, key, value in extract_data(settings):
    print(f"Path: {path}")
    print(f"Key: {key}")
    print(f"Value: {value}\n")

    os.system(f"gsettings set {path} {key} {value}")
