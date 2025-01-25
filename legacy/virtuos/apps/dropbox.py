# system imports --------------------------------------------------------------------------------- #
import os

# third-party imports ---------------------------------------------------------------------------- #
import requests
from bs4 import BeautifulSoup

# script ----------------------------------------------------------------------------------------- #
url = "https://www.dropbox.com/download?dl=packages/ubuntu"

print("Fetching download page...", end="")
response = requests.get(url)
if response.status_code != 200:
    print("\tFailed")
    exit(1)
else:
    print("\tDone")

print("Parsing download page...", end="")
soup = BeautifulSoup(response.content, "html.parser")
links = soup.find_all("a", href=True)
file_links = [link["href"] for link in links if link["href"].endswith(".deb")]
print("\tDone")

print("Locating download link...", end="")
files = []
for file_link in file_links:
    if file_link.startswith("dropbox_"):
        files.append(file_link)
file = files[-1]
print("\tDone")

os.system(f"wget {url}/{file} -O $HOME/Downloads/{file}")
os.system(f"sudo dpkg -i $HOME/Downloads/{file}")

print("Disabling integration...", end="")
os.system("sudo mv /usr/lib/x86_64-linux-gnu/nautilus/extensions-4/libnautilus-dropbox.so{,.bak}")
print("\tDone")
