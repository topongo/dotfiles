#!/usr/bin/env python3
import os

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


nm = {
    101: "topongoPC",
    102: "tardis",
    104: "raspserver",
    105: "esp",
    107: "huawei",
    161: "dell",
    162: "p5k"
}

if __name__ == "__main__":
    for i in nm:
        print(nm[i], "is ", end="")
        if os.system(f"ping -c 1 -w 5 192.168.2.{i} > /dev/null"):
            print(f"{bcolors.FAIL}dead{bcolors.ENDC}")
        else:
            print(f"{bcolors.OKGREEN}alive{bcolors.ENDC}")
