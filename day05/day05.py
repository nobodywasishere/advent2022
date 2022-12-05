#!/usr/bin/env python

import re

stuff = open('input.txt', 'r').read().split('\n\n')

stacks = stuff[0].splitlines()

bins = list(map(int, re.sub(' +', ' ', stacks[-1]).strip().split(' ')))
bins = { b: [] for b in bins }

for i in range(len(bins)):
    for j in reversed(range(len(stacks) - 1)):
        if stacks[j][4*(i+1)-3].strip():
            bins[i+1].append(stacks[j][4*(i+1)-3])

instrs = stuff[1].splitlines()
for i in range(len(instrs)):
    t = instrs[i].split(' ')
    instrs[i] = [int(t[1]), int(t[3]), int(t[5])]

for instr in instrs:
    for i in range(instr[0]):
        bins[instr[2]].append(bins[instr[1]].pop())

out = []

for b in bins.keys():
    out.append(bins[b][-1])

print(f"part 1: {''.join(out)}")


stacks = stuff[0].splitlines()

bins = list(map(int, re.sub(' +', ' ', stacks[-1]).strip().split(' ')))
bins = {b: [] for b in bins}

for i in range(len(bins)):
    for j in reversed(range(len(stacks) - 1)):
        if stacks[j][4*(i+1)-3].strip():
            bins[i+1].append(stacks[j][4*(i+1)-3])

instrs = stuff[1].splitlines()
for i in range(len(instrs)):
    t = instrs[i].split(' ')
    instrs[i] = [int(t[1]), int(t[3]), int(t[5])]

for instr in instrs:
    bins[instr[2]] += bins[instr[1]][-instr[0]:]
    del bins[instr[1]][-instr[0]:]

out = []

for b in bins.keys():
    out.append(bins[b][-1])

print(f"part 2: {''.join(out)}")
