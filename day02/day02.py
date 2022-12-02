#!/usr/bin/env python

stuff = open('input.txt', 'r').read().splitlines()

score = 0
for i in range(len(stuff)):
    turn = stuff[i].replace('A', '1').replace(
        'X', '1').replace('B', '2').replace('Y', '2').replace('C', '3').replace('Z', '3').split(' ')

    score += int(turn[1])
    if turn[0] == turn[1]:
        score += 3
    elif (turn[0] == '1' and turn[1] == '2') or \
        (turn[0] == '2' and turn[1] == '3') or \
        (turn[0] == '3' and turn[1] == '1'):
        score += 6

print(f"part 1: {score}")

score = 0
for i in range(len(stuff)):
    turn = stuff[i].replace('A', '1').replace(
        'X', '0').replace('B', '2').replace('Y', '3').replace('C', '3').replace('Z', '6').split(' ')

    score += int(turn[1])
    if turn[1] == '0':
        if turn[0] == '1':
            score += 3
        elif turn[0] == '2':
            score += 1
        elif turn[0] == '3':
            score += 2
    elif turn[1] == '3':
        score += int(turn[0])
    elif turn[1] == '6':
        if turn[0] == '1':
            score += 2
        elif turn[0] == '2':
            score += 3
        elif turn[0] == '3':
            score += 1

print(f"part 2: {score}")
