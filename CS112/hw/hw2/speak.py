#!/usr/bin/env python

# John Allard
# CS112 HW #2 Problem #11


# Grading Note -- Just run in a python 2.7 interpreter. It will prompt you from stdin for a string containing
# the integer you want conveted to english, give it something like "98329827492837498273", and it will print
# the english representation to stdout before exiting.

import sys

rest = ["", "thousand", "million", "billion", "trillon", 
        "quadrillion", "quintillion", "sextillion", 
        "septillion", "octillion", "nonillion", "decillion", 
        "undecillion", "duodecillion", "tredecillion", "quattuordecillion", 
        "quindecillion", "sexdecillion", "septendecillion", 
        "octodecillion", "novemdecillion", "vigintillion"]

def groupothree(group) :
    teens = ["ten", "eleven", "twelve", "thirteen", "fourteen", 
            "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    tens = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    ones = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    hx = tx = ox = ""
    if(len(group) == 3) :
        hx = "" if int(group[0]) == 0 else (ones[int(group[0])] + " hundred ")
        tx = "" if int(group[1]) == 0 else (teens[int(group[2])] if int(group[1]) == 1 else tens[int(group[1])-1] + " ")
        ox = "" if int(group[2]) == 0 or int(group[1]) == 1 else ones[int(group[2])]
    elif(len(group) == 2) :
        tx = "" if int(group[0]) == 0 else (teens[int(group[1])] if int(group[0]) == 1 else tens[int(group[0])-1] + " ")
        ox = "" if (int(group[1]) == 0 or int(group[1]) == 1) else ones[int(group[1])]
    elif(len(group) == 1) :
        ox = "" if int(group[0]) == 0 else ones[int(group[0])]

    return hx+tx+ox 


if __name__ == "__main__" :
    bigint = ""
    if len(sys.argv) > 1 :
        bigint = sys.argv[1].lstrip()
    else :
        print "Please enter a big integer"
        bigint = sys.stdin.readline()

    bigint = ''.join([c for c in bigint if c in '0123456789']).lstrip()

    # bunch of reverses here to nest the string into groups of threes where precedence is givin
    # to lower order digits for grouping
    bilist = bigint[::-1]

    # gotten here http://stackoverflow.com/questions/9475241/split-python-string-every-nth-character
    # splits string of chars into groups of three
    bilist = [bilist[i:i+3] for i in range(0, len(bilist), 3)]

    bilist = [x[::-1] for x in bilist]
    bilist = bilist[::-1]

    # now bilist consists of ['x', 'xxx', 'xxx', ... 'xxx'] which are the groupings of three digits with
    # grouping precedence givin to lower order terms, now we index and concatinate.
    unfolded = []
    final = ""
    for group in bilist :
        unfolded.append(groupothree(group))

    for ix, group in enumerate(unfolded) :
        final = final + group + " " + rest[len(unfolded)-ix-1] + " "

    final = final.replace("  ", " ")
    print final
      
