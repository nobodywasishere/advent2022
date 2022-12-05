#!/usr/bin/env python

stuff = open('input.txt', 'r').read().strip().splitlines()

score = 0

for i in range(len(stuff)):
    e1, e2 = stuff[i].split(',')

    e1l, e1h = map(int, e1.split('-'))
    e2l, e2h = map(int, e2.split('-'))

    if e1l in range(e2l, e2h+1) and e1h in range(e2l, e2h+1) or \
        e2l in range(e1l, e1h+1) and e2h in range(e1l, e1h+1):
        score += 1

print(f"part 1: {score}")

score = 0

for i in range(len(stuff)):
    e1, e2 = stuff[i].split(',')

    e1l, e1h = map(int, e1.split('-'))
    e2l, e2h = map(int, e2.split('-'))

    if any(e in range(e2l, e2h+1) for e in range(e1l, e1h+1)) or \
        any(e in range(e1l, e1h+1) for e in range(e2l, e2h+1)):
        score += 1

print(f"part 2: {score}")
