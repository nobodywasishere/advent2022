#!/usr/bin/pypy3

import os, sys

stuff = open('input.txt', 'r').read().split('\n\n')

for i in range(len(stuff)):
    if stuff[i]:
        stuff[i] = sum(map(int, stuff[i].split('\n')))
    else:
        stuff[i] = 0

print(f"part 1: {max(stuff)}")

total = max(stuff)
stuff.remove(max(stuff))
total += max(stuff)
stuff.remove(max(stuff))
total += max(stuff)

print(f"part 2: {total}")
