#!/bin/gawk -f

# https://adventofcode.com/2022/day/4

# Part 1: Determine whether a range fully overlaps another range or not

BEGIN {
    FS = ","
}

function is_range_inside_other_range(first_elf, second_elf) {
    split(first_elf, first_range, "-", seps)
    split(second_elf, second_range, "-", seps)
    if (first_range[1] < second_range[1]) {
        # the first range might surround the second range
        if (first_range[2] >= second_range[2]) {
            return 1
        }
        else {
            return 0
        }
    }
    else if (second_range[1] < first_range[1]) {
        # the second range might surround the first range
        if (second_range[2] >= first_range[2]) {
            return 1
        }
        else {
            return 0
        }
    }
    else {
        # the ranges start in the same place, so by
        # definition either one is longer than the other
        # and the shorter one is completely within the other
        # or they completely overlap each other
        return 1
    }
}

function do_ranges_overlap_at_all(first_elf, second_elf) {
    split(first_elf, first_range, "-", seps)
    split(second_elf, second_range, "-", seps)
    if (first_range[1] < second_range[1]) {
        # the first range starts before the second range and may
        # extend into it, e.g. 5-7,7-9
        if (first_range[2] >= second_range[1]) {
            return 1
        }
        else {
            return 0
        }
    }
    else if (second_range[1] < first_range[1]) {
        # same as above but with positions swapped, e.g. 7-9,5-7
        if (second_range[2] >= first_range[1]) {
            return 1
        }
        else {
            return 0
        }
    }
    else {
        # the ranges start in the same place, so by
        # definition they overlap
        return 1
    }
}

{
    part_1_accumulator += is_range_inside_other_range($1, $2)
    part_2_accumulator += do_ranges_overlap_at_all($1, $2)
}

END {
    print "Part 1:", part_1_accumulator
    print "Part 2:", part_2_accumulator
}