#!/usr/bin/env python3

# open file
import sys
my_sam = open(sys.argv[1])

align_dict = {}
mis_dict = {}
# Process line by line a .sam file specified as the first command line argument
for line in my_sam:
    if line.rstrip().startswith("@"): #Skip header lines that begin with @
        continue
    else:
#Use a dictionary and count how many alignments there are for each chromosome (and unmapped) as reported in the RNAME field
        columns=line.strip("\n").split("\t")
        RNAME=columns[2]
        if RNAME not in align_dict:
            align_dict[RNAME]=1
        else:
            align_dict[RNAME]+=1
#Print each dictionary key, value pair in the default order returned by .keys()- see below
#Yes, the number match indxstats

# Extend summarize-sam.py to examine mismatches per alignment
# Count how many times each NM:i:count SAM tag occurs
# Note that NM is not always in the same column so use a for loop to go through the fields after splitting a line
        for field in columns:
            if field.startswith("NM:i:"): #if that column in each line starts with NM:i:
# For the dictionary key, remove the NM:i: by slicing and convert to int()
                mismatch= int(field[5:]) # the count is the 5th (start from 0) object in the string "NM:i:#)"
                if mismatch not in mis_dict:
                    mis_dict[mismatch]=1
                else:
                    mis_dict[mismatch]+=1
# Print the dictionary keys in numerical order by first using the sorted() function e.g.
print(align_dict)
for key in (mis_dict.keys()):
    print(key, mis_dict[key])
    
