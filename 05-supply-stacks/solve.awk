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
    # first replace empty spaces with an empty box
    gsub("   ", "\133 \135", $0)
    # then replaces the boxes because awk gets upset if [ and ] are in the same regex, even if they are escaped
    gsub(/\]/, "|", $0)
    gsub(/\[/, "", $0)
    # now that the fields are setup, grab the letter from the box
    # and put it into the boxes array
    for (i = 1; i < NF; i++) {
        match($i, /[A-Z]/, letter)
        boxes[i] = letter[0] " " boxes[i]
    }
    #print(boxes[2])
    #    P C J B; the top is at the end of the array
}