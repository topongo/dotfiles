#!/usr/bin/env python
from time import time


input("Press enter when ready")
start = time()
count = 0
while True:
    input()
    count += 1
    print(f"{count/(time()-start)*60:4.1f} BPM", end="")

