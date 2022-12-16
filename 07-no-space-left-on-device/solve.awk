#!/bin/gawk -f

# https://adventofcode.com/2022/day/7

# Part 1, find the directories whose contents are smaller than 100_000
# Part 2, find the smallest directory that, if deleted, will free up enough space.

BEGIN {
    current_path[1] = ""
    directory_sums[current_path[1]] = 0
}

function adjust_directory_sums(new_value,    partial_path, len, i) {
# An array with the current total of each directory
    len = length(current_path)
    partial_path = ""
    for (i = 1; i <= len; i++) {
        if (partial_path == "") {
            partial_path = current_path[i]
        }
        else {
            partial_path = partial_path "|" current_path[i]
        }
        directory_sums[partial_path] += new_value
    }
}

function pop(arr,    ret, len) {
    len = length(arr)
    ret = arr[len]
    delete arr[len]
    return ret
}

function push(arr, new_value,    len) {
    len = length(arr)
    arr[len + 1] = new_value
}

function join(arr, sep,   ret, i) {
    ret = ""
    for (i in arr) {
        if (ret == "") {
            ret = arr[i]
        }
        else {
            ret = ret sep arr[i] 
        }
    }
    return ret
}

/\$ cd/ {
    if ($NF == "..") {
        current_directory = pop(current_path)
    }
    else {
        push(current_path, $NF)
    }
}

/^[0-9]/ {
    adjust_directory_sums($1)
}

END {
    part_1_adder = 0
    fs_space = 70000000
    used = directory_sums["/"]
    free = fs_space - used
    needed = 30000000 - free
    smallest_deletable = 0
    print "Used: ", used, "Free: ", free, "Needed: ", needed
    for (d in directory_sums) {
        if (directory_sums[d] <= 100000) {
            part_1_adder += directory_sums[d]
        }
        if (directory_sums[d] >= needed) {
            if (smallest_deletable == 0 || smallest_deletable > directory_sums[d]) {
                smallest_deletable = directory_sums[d]
            }
        }
    }
    print "Part 1: ", part_1_adder
    print "Part 2: ", smallest_deletable
}
