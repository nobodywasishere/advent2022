#!/usr/bin/env python

from math import floor

stuff = open('input.txt', 'r').read().splitlines()

score = 0

for i in range(len(stuff)):
    comp1 = stuff[i][0:floor(len(stuff[i])/2)]
    comp2 = stuff[i][floor(len(stuff[i])/2):]

    let = [w for w in set(comp1) if w in comp2][0]

    if 97 <= ord(let) <= 122:
        score += ord(let) - 96
    else:
        score += ord(let) - 38

print(f"part 1: {score}")

score = 0

for i in range(floor(len(stuff)/3)):
    let = [w for w in set(stuff[3*i]) if w in stuff[(3*i)+1] and w in stuff[(3*i)+2]][0]

    if 97 <= ord(let) <= 122:
        score += ord(let) - 96
    else:
        score += ord(let) - 38

print(f"part 2: {score}")
