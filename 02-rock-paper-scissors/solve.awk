#!/bin/awk -f

# https://adventofcode.com/2022/day/2

# Part 1:

# A = opponent picks rock
# B = opponent picks paper
# C = opponent picks scissors
# X = I pick rock, 1 point
# Y = I pick paper, 2 point
# Z = I pick scissors, 3 point
# I lose = 0 points
# Draw = 3 points
# I win = 6 points

# Part 2: 

# A = opponent picks rock
# B = opponent picks paper
# C = opponent picks scissors
# X = I need to lose 
# Y = I need to draw
# Z = I need to win
# I lose = 0 points
# Draw = 3 points
# I win = 6 points
# rock 1, paper 2, scissors 3

BEGIN {
    part_1_score = 0
    part_2_score = 0
}

/A X/ { # lose against rock
    part_1_score += 1+3
    part_2_score += 0+3
}
/A Y/ { # draw against rock
    part_1_score += 2+6
    part_2_score += 3+1
}
/A Z/ { # win against rock
    part_1_score += 3+0
    part_2_score += 6+2 
}
/B X/ { # lose against paper
    part_1_score += 1+0
    part_2_score += 0+1
}
/B Y/ { # draw against paper
    part_1_score += 2+3
    part_2_score += 3+2
}
/B Z/ { # win against paper
    part_1_score += 3+6
    part_2_score += 6+3
}
/C X/ { # lose against scissors
    part_1_score += 1+6
    part_2_score += 0+2
}
/C Y/ { # draw against scissors
    part_1_score += 2+0
    part_2_score += 3+3
}
/C Z/ { # win against scissors
    part_1_score += 3+3
    part_2_score += 6+1
}

END { 
    print "Part 1:", part_1_score
    print "Part 2:", part_2_score
}