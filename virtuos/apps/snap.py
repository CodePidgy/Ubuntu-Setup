# system imports --------------------------------------------------------------------------------- #
import os

# script ----------------------------------------------------------------------------------------- #
apps = [["code", True], ["spotify", False], ["thunderbird", False]]

for app in apps:
    os.system(f"sudo snap install {'--classic' if app[1] else ''} {app[0]}")
