#!/usr/bin/env python
from urllib.parse import quote_plus, unquote_plus
from sys import stdin, argv

if len(argv) <= 1 or argv[1] == "decode":
  print(unquote_plus(stdin.read()))
else:
  print(quote_plus(stdin.read()))
