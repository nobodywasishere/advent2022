#!/usr/bin/env python

import os
import copy
from collections import OrderedDict as od

from pprint import pprint

stuff = open('input.txt', 'r').read().split('$')
cmds = [w.strip().splitlines() for w in stuff if w]

cdir = ''
sums = {}

for cmdi in range(len(cmds)):
    c = cmds[cmdi][0].split(' ')[0]
    a = cmds[cmdi][0].split(' ')[1] if len(cmds[cmdi][0].split(' ')) > 1 else None
    
    if c == 'ls':
        t = 0
        for file in cmds[cmdi][1:]:
            s = file.split(' ')[0]
            n = file.split(' ')[1]
            if s != 'dir':
                t += int(s)

        sums[cdir] = t

    elif c == 'cd' and a is not None:
        if a == '..':
            cdir = os.path.split(cdir[:-1])[0]
            if cdir[-1] != '/':
                cdir += '/'
        elif a[0] == '/':
            cdir = a
        else:
            cdir += a + '/'


keys = list(reversed(sorted(sums, key=lambda t: (t.count('/'), t))))

for d in keys:
    for sd in sums.keys():
        if sd.startswith(d) and sd != d and sd.count('/') - 1 == d.count('/'):
            sums[d] += sums[sd]

t = sum([ sums[q] for q in sums if sums[q] < 100000 ])

print(f'part 1: {t}')

space_needed = sums['/'] - (70000000-30000000)

m = sums['/']

for d in sums.keys():
    if sums[d] <= space_needed:
        continue
    m = sums[d] if sums[d] <= m else m

print(f"part 2: {m}")
