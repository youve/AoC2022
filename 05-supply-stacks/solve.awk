#!/bin/gawk -f

# https://adventofcode.com/2022/day/5

@include "join.awk"
function move_boxes_one_at_a_time(line,    arr, amount, src, dest, i) {
    split(line, arr, /[a-z ]*/)
    amount = arr[2]
    src = arr[3]
    dest = arr[4]

    for (i = 0; i < amount; i++) {
        print "Before:"
        inspect_stacks()
        push(stacks, dest, pop(stacks, src))
        print "After:"
        inspect_stacks()
        print "============="
    }
}


function move_boxes(line,    arr, amount, src, dest, i) {
    split(line, arr, /[a-z ]*/)
    amount = arr[2]
    src = arr[3]
    dest = arr[4]

    print "Before:"
    inspect_stacks()
    push_many(stacks, dest, pop_many(stacks, src, amount))
    print "After:"
    inspect_stacks()
    print "============="
}

function push(arr, i, new_item) {
    new_index = get_arr_length(arr,i) + 1
    arr[i,new_index] = new_item
}

function push_many(arr, i, new_arr) {
    for (j = 1; j <= length(new_arr); j++) {
        push(arr, i, new_arr[j])
    }
}

function get_arr_length(arr, i) {
    j = 1
    while (length(arr[i,j]) > 0) {
        j++
    }
    return j - 1
}

function pop(arr, i,    ret) {
    ret = arr[i,get_arr_length(arr, i)]
    arr[i,get_arr_length(arr, i)] = ""
    return ret
}

function pop_many(arr, i, amount,    str, ret_arr) {
    for (j = 0; j < amount; j++) {
        str = pop(arr, i) " " str
    }
    split(str, ret_arr)
    return ret_arr
}

function inspect_stacks(      line) {
    for (i = 1; i < 10; i++) {
        line = ""
        for (j = 1; j < 30; j++) {
            line = line stacks[i,j]
        }
        print i " " line
    }
}

BEGIN {
}

/move/ {
    move_boxes_one_at_a_time($0)
    # doesn't work yet
    # move_boxes($0)
}

!/move/ {
    # populate initial boxes array and handle blank spaces meaningfully
    # first replace empty spaces with an empty box
    gsub("   ", "\133 \135", $0)
    # then replaces the boxes because awk gets upset if [ and ] are in the same regex, even if they are escaped
    gsub(/\]/, "|", $0)
    gsub(/\[/, "", $0)
    # now that the fields are setup, grab the letter from the box
    # and put it into the boxes array (really a string)
    for (i = 1; i <= NF; i++) {
        match($i, /[A-Z]/, letter)
        boxes[i] = letter[0] " " boxes[i]
    }
    #    P C J B; the top is at the end of the string
}

/^$/ {
    # turn the boxes list of strings into a multidimensional stacks array
    for (i = 1; i <= length(boxes); i++) {
        split(boxes[i], temp)
        for (j = 1; j <= length(temp); j++) {
            stacks[i,j] = temp[j]
        }
    }
}

END {
    i = 1
    top = stacks[i,get_arr_length(stacks,i)]
    answer = ""
    for (i = 0; i < 10; i++) {
        top = stacks[i,get_arr_length(stacks,i)]
        # gsub(/[ \t]+$/, "" top)
        answer = answer top
    }
    inspect_stacks()
    print answer
}