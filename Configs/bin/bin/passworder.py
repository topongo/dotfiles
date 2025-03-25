#!/usr/bin/env python
from sys import stdin, stderr, argv
from getpass import getpass
import select

alph = "abcdefghijklmnopqrstuvwxyz"


def shift(string, n):
    for i in string:
        if i.lower() in alph:
            l = i.islower()
            t_letter = alph[(alph.index(i.lower())+n) % len(alph)]
            print(t_letter if l else t_letter.upper(), end="")
            continue
        try:
            i = int(i)
            print((i + n) % 10, end="")
        except ValueError:
            print(i, end="")


if __name__ == "__main__":
    if len(argv) > 1:
        try:
            n = int(argv[1])
        except ValueError:
            print(f"invalid shift amount: {argv[1]}", file=stderr)
            exit(1)
    else:
        n = 1
    try:
        if select.select([stdin.buffer], [], [], 0.0)[0]:
            shift(stdin.buffer.read().strip(), n)
        else:
            shift(getpass("Insert string to shift: "), n)
        print()
    except KeyboardInterrupt:
        exit()
