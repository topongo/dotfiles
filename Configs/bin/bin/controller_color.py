from time import sleep
from colorsys import hls_to_rgb
from os import listdir, kill, getpid
from itertools import cycle
from os.path import exists

LOCK = "/tmp/controller_color.py"

if exists(LOCK):
    with open(LOCK) as f:
        pid = int(f.read())
    try:
        kill(pid, 0)
        print("Already running.")
        exit(0)
    except OSError:
        pass

with open(LOCK, "w+") as f:
    f.write(str(getpid()))

stop = False
while not stop:
  for i in listdir("/sys/class/leds/"):
    if i.startswith("0005") and i.endswith("red"):
      addr = i.replace(":red", "")
      stop = True
  sleep(.1)


SPEED = 4.0
samp = 1.0*600/SPEED
for i in cycle(range(int(samp))):
  colors = hls_to_rgb(i/samp, 0.5, 1)
  for c, v in zip(("red", "green", "blue"), colors):
    with open(f"/sys/class/leds/{addr}:{c}/brightness", "w+") as f:
      f.write(str(int(40*v)))
  sleep(.05)
