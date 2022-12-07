#!/bin/gawk -f

# https://adventofcode.com/2022/day/5

function move_boxes_one_at_a_time(line,    arr, amount, src, dest, i) {
    # given a line like move 3 from 2 to 1,
    # move `amount` boxes from `src` to `dest`
    # one at a time, so that the orders are reversed
    split(line, arr, /[a-z ]*/)
    amount = arr[2]
    src = arr[3]
    dest = arr[4]

    for (i = 0; i < amount; i++) {
        push(stacks, dest, pop(stacks, src))
    }
}


function move_boxes(line,    arr, amount, src, dest, i) {
    # given a line like move 3 from 2 to 1,
    # move `amount` boxes from `src` to `dest`
    # without reordering the boxes during the move.
    split(line, arr, /[a-z ]*/)
    amount = arr[2]
    src = arr[3]
    dest = arr[4]

    push_many(stacks, dest, pop_many(stacks, src, amount))
}

function push(arr, i, new_item,    new_index) {
    # push `new_item` onto the `i`th subarray of the
    # multidimensional array `arr`
    new_index = get_arr_length(arr,i) + 1
    arr[i,new_index] = new_item
}

function push_many(arr, i, str,     new_arr, j) {
    # push the contents of `str` onto the `i`th subarray of the
    # multidimensional array `arr`
    # str accepts a string because awk can't return an array
    # so that push_many can accept the return value of pop_many
    # but it also accepts an array
    if (typeof(str) == "string") {
        split(str, new_arr)
    }
    else {
        new_arr = str
    }
    for (j = 1; j <= length(new_arr); j++) {
        push(arr, i, new_arr[j])
    }
}

function get_arr_length(arr, i,     j) {
    # return the length of the `i`th subarray of the multidimensional
    # array `arr`
    j = 1
    while (length(arr[i,j]) > 0) {
        j++
    }
    return j - 1
}

function pop(arr, i,    ret) {
    # pop from the `i`'th subarray in the multidimenisonal array `arr`
    # return a string
    ret = arr[i,get_arr_length(arr, i)]
    arr[i,get_arr_length(arr, i)] = ""
    return ret
}

function pop_many(arr, i, amount,    j, str) {
    # pop the last `amount` items from the `i`'th subarray in the
    # multidimensional array `arr`
    # returns a string because awk can't return arrays
    for (j = 0; j < amount; j++) {
        str = pop(arr, i) " " str
    }
    return str
}

function inspect_stacks(      i, j, line) {
    # print a multidimensional array for inspection
    for (i = 1; i < 10; i++) {
        line = ""
        for (j = 1; j < 30; j++) {
            line = line stacks[i,j]
        }
        print i " " line
    }
    print ""
}

/move/ {
    # Part 1: 
    # move_boxes_one_at_a_time($0)
    # Part 2:
    move_boxes($0)
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
    print "Starting arrangement: "
    inspect_stacks()
}

END {
    i = 1
    top = stacks[i,get_arr_length(stacks,i)]
    answer = ""
    for (i = 0; i < 10; i++) {
        top = stacks[i,get_arr_length(stacks,i)]
        answer = answer top
    }
    print "Final arrangement:"
    inspect_stacks()
    print answer
}