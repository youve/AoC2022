#!/bin/gawk -f

# https://adventofcode.com/2022/day/6

# What is the position of the last character in a run of 4 unique
# characters? e.g.
# mjqjpqmgbljsphdztnvjfqwrcgsmlb
# ......7 <-jpqm is the first run of 4 unique characters and m is
# in position 7 (index from 1)

function solve(runlength,   a, i, counter) {
    for (a = 1; a < length($0) - runlength; a++) {
        delete counter
        for (i = 0; i < runlength; i++) {
            counter[substr($0, a + i, 1)]++
        }
        if (length(counter) == runlength) {
            return a + runlength - 1
        }
    }
}

{
    print "Part 1:", solve(4)
    print "Part 2:", solve(14)
}