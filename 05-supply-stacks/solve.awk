#!/bin/gawk -f

# https://adventofcode.com/2022/day/5

function move_boxes(line) {

}

BEGIN {
}

/move/ {
    move_boxes($0)
}

!/move/ {
    # populate initial boxes array and handle blank spaces meaningfully
    gsub("   ", "\133 \135", $0)
    gsub(/\]/, "|", $0)
    gsub(/\[/, "", $0)
    for (i = 1; i < NF; i++) {
        match($i, /[A-Z]/, letter)
        boxes[i] = letter[0] " " boxes[i]
    }
    print(boxes[2])
    #    P C J B the top is at the end of the array
}