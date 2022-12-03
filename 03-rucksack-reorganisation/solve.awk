#!/bin/gawk -f

# Find the items that appear in both halves of the string
# And sum their values
# a-z = 1-26
# A-Z = 27-52

@include "../lib/ord.awk"
BEGIN {
    _ord_init()
    a = ord("a") # 97
    z = ord("z")
    A = ord("A") # 65
    Z = ord("Z")
}

function solve_part_1() {
    compartment_size = length($0) / 2
    first_half = substr($0, 0, compartment_size)
    second_half = substr($0, compartment_size + 1)

    for (i = A; i <= z; i++) {
        if (index(first_half, chr(i)) > 0 && index(second_half, chr(i)) > 0) {
            if (i >= a) {
                priority += i - 96
            }
            else {
                priority += i - 38
            }
        }
    }
}

function solve_part_2(first_sack, second_sack, third_sack) {

    for (i = A; i <= z; i++) {
        if (index(first_sack, chr(i)) > 0 && index(second_sack, chr(i)) > 0 && index(third_sack, chr(i)) > 0) {
            if (i >= a) {
                part_2_priority += i - 96
            }
            else {
                part_2_priority += i - 38
            }
        }
    }
}

NR % 3 == 1 {
    first_sack = $0
}
NR % 3 == 2 {
    second_sack = $0
}

NR % 3 == 0 {
    third_sack = $0
    solve_part_2(first_sack, second_sack, third_sack)
}

{
    solve_part_1()
}

END {
    print "Part 1:", priority
    print "Part 2:", part_2_priority
}