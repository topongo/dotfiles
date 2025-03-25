#!/usr/bin/env python
from sys import argv

DEV = "/sys/class/backlight/amdgpu_bl1"

def current():
    with open(DEV + "/brightness") as f:
        return int(f.read()) 

if len(argv) < 2:
    print("Usage: %s up|down [amount]" % argv[0])
    exit(1)

cur = current() * 100 / 255
amount = int(argv[2]) if len(argv) > 2 else 5

if argv[1] == "up":
    target = cur + amount
elif argv[1] == "down":
    target = cur - amount
elif argv[1] == "set":
    if len(argv) < 3:
        print("Usage: %s set amount" % argv[0])
        exit(1)
    target = int(argv[2])
else:
    print("Usage: %s up|down [amount]" % argv[0])
    exit(1)

if argv[1] != "set":
    target = round(target / 5) * 5
target = max(0, min(100, target))

if current() != int(target / 100 * 255):
    with open(DEV + "/brightness", "wb") as f:
        f.write(str(int(target / 100 * 255)).encode())

