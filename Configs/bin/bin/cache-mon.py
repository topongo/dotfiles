#!/usr/bin/env python3

from shutil import get_terminal_size
from typing import Any

def format_size(size: int|float) -> str:
    power = 1 << 10
    units = ["B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB"]
    for unit in units:
        if size < power:
            return f"{size:.2f} {unit}"
        size /= power

    return f"{size:.2f} {units[-1]}"


if __name__ == "__main__":
    columns, _ = get_terminal_size()

    with open("/proc/meminfo", "r") as f:
        lines = f.readlines()
        meminfo: dict[str, int] = {}
        for line in lines:
            k, v = line.split(":")
            k, v = k.strip(), v.strip()

            v = int(v.split(" ")[0]) * 1024

            meminfo[k] = v


    out = []
    for i in (
        ("drt", "Dirty"),
        ("wrt", "Writeback"),
        ("wtt", "WritebackTmp"),
    ):
        lab, key = i
        val = meminfo[key]
        label = f"{lab}: {format_size(val)}: "
        out.append({
            "label": label,
            "value": val,
        })

    mx_label = len(max(out, key=lambda x: len(x["label"]))["label"])
    mx_val = max(out, key=lambda x: x["value"])["value"]
    mx_val = max(mx_val, 1 << 32)

    # 3 for label, 1 for color, 1 for space, max num length
    space = mx_label + 1
    for i in out:
        label = i["label"]
        val = i["value"]
        percent = (val / mx_val) * 100
        bar = "█" * int((columns - space) * (percent / 100))
        print(f"{label:<{mx_label}}{bar:<{columns - space}}")

