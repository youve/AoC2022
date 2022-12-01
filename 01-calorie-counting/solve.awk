#!/usr/bin/awk -f

# https://adventofcode.com/2022/day/1
# Part 1: How many calories are carried by the elf who is carrying the most calories?
# Part 2: Same but top 3 elves.

BEGIN {
    RS = "";
}

function indexOfSmallest(arr) {
    if ((arr[0] <= arr[1]) && (arr[0] <= arr[2])) {
        return 0
    }
    else if (arr[1] <= arr[2]) {
        return 1
    }
    return 2
}

{
    rowTotal = 0
    for (i = 1; i <=NF; i++) {
        rowTotal += $i
    }
    n = indexOfSmallest(max);
    max[n] = (max[n] > rowTotal) ? max[n] : rowTotal
}

END {
    print "Top three:", max[0], max[1], max[2];
    print "Total:", max[0] + max[1] + max[2];
}
