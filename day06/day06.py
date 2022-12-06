#!/usr/bin/env python

stuff = open('input.txt', 'r').read().splitlines()

for line in stuff:
    past = []
    for i in range(len(line)):

        if len(past) == 4:
            if len(set(past)) == 4:
                print(f"part 1: {i}")
                break

            del past[0]
        past.append(line[i])

for line in stuff:
    past = []
    for i in range(len(line)):

        if len(past) == 14:
            if len(set(past)) == 14:
                print(f"part 2: {i}")
                break

            del past[0]
        past.append(line[i])
