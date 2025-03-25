#!/usr/bin/env python
from subprocess import Popen
from random import randint

if randint(0, 100) > 5:
    s = Popen(["konsole"])
else:
    s = Popen(["cool-retro-term"])
