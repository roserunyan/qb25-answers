#! /usr/bin/env python3

#Recalculate ce11_genes.bed scores using Python
import sys
my_file = open(sys.argv[1]) #firt argument is script

#Write a script that for each feature (line) recalculates the score (column 5) such that
#new_score = original_score * feature_size
final_score = []
for line in my_file:
    line=line.rstrip().split("\t") #split by tabs and remove newline
    score=int(line[4])
    start=int(line[1])
    end=int(line[2])
    size=end-start
    new_score= score * size
    #new_score is positive or negative based on the strand (column 6)
    strand=line[5]
    if strand == "-":
        #final_score.append(new_score)
        new_score = new_score * -1
        #final_score.append(new_score)
#Print out all six columns in BED format
    print(line[0] + "\t" + line[1] + "\t" + line[2] + "\t" + line[3] + "\t" + str(new_score) + "\t" + line[5])

#chrI	8377406	8390027	NM_059873.7	-75726	-
#chrI	8377598	8392758	NM_182066.7	-7610320	-
#chrI	8377600	8392768	NM_001129046.3	-106176	-
#chrI	1041473	1049600	NM_058410.5	3868452	+
#chrI	3144409	3147793	NM_058707.5	-1796904	-