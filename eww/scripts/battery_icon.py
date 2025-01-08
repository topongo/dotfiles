from json import loads
from sys import stdin

icons = {
    False: {0: "󰂎", 1: "󰁺", 2: "󰁻", 3: "󰁼", 4: "󰁽", 5: "󰁾", 6: "󰁿", 7: "󰂀", 8: "󰂁", 9: "󰂂", 10: "󰁹"},
    True: {0: "󰢟", 1: "󰢜", 2: "󰂆", 3: "󰂇", 4: "󰂈", 5: "󰢝", 6: "󰂉", 7: "󰢞", 8: "󰂊", 9: "󰂋", 10: "󰂅"},
}

while True:
    l = stdin.readline()
    if l == "":
        break
    data = loads(l)["BAT0"]
    print(icons[data["status"] == "Charging"][round(data["capacity"] / 10)], flush=True)



