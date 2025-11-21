#! /usr/bin/env python3

#====================#
# Read in parameters #
#====================#

# Import read fasta and numpy
from fasta import readFASTA
import numpy as np

# read in fasta file
import sys
paramters_file = open(sys.argv[1]) # fasta file
scoring_matrix = open(sys.argv[2]) # scoring martix file
out_file = open(sys.argv[3], 'w') # output file

input_sequences = readFASTA(paramters_file)
seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]

# create dictionary of scoring matrix
fs = scoring_matrix
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Check output
#print(sigma)


#=====================#
# Initialize F matrix #
#=====================#

# Initialize two empty matrices:
# create F-matrix that stores the score of each "optimal" sub-alignment
F_matrix = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=int)
#print(F_matrix) # check


#=============================#
# Initialize Traceback Matrix #
#=============================#
# create a traceback matrix that allows you to determine the optimal global alignment (as a path through this matrix)
trace_matrix = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=object)


#===================#
# Populate Matrices #
#===================#

# define gap penalty: -10 for protein, -300 for DNA; match and mismatch scores
gap_penalty = -10
match_score = 100
mismatch_score = -100

# fill in first row and column based on gap penalty
for i in range(1, len(sequence1) + 1):
    F_matrix[i,0] = F_matrix[i-1,0] + gap_penalty

for j in range(1,len(sequence2) + 1):
    F_matrix[0,j] = F_matrix[0,j-1] + gap_penalty #filel in first row, score of 1st gap plus one more penalty
# print(F_matrix)

# fill in F matrix
for i in range(1, len(sequence1)+1): # loop through rows
	for j in range(1, len(sequence2)+1): # loop through columns
		if sequence1[i-1] == sequence2[j-1]: # if sequence1 and sequence2 match at positions i and j, respectively...
			d = F_matrix[i-1, j-1] + match_score
		else: # if sequence1 and sequence2 don't match at those positions...
			d = F_matrix[i-1, j-1] + mismatch_score
		h = F_matrix[i,j-1] + gap_penalty
		v = F_matrix[i-1,j] + gap_penalty

		F_matrix[i,j] = max(d,h,v)

#print(F_matrix)

# fill in traceback matrix- I used chatGPT for some help
# fill in first row and column based on gap penalty
for i in range(1, len(sequence1) + 1):
    trace_matrix[i,0] = "↑" # sequence 1 is on left, so goes up

for j in range(1,len(sequence2) + 1):
    trace_matrix[0,j] = "←" # sequence 2 is on the top, so it goes left

# fill in the rest
for i in range(1, len(sequence1)+1): # loop through rows
	for j in range(1, len(sequence2)+1): # loop through columns
		if sequence1[i-1] == sequence2[j-1]: # if sequence1 and sequence2 match at positions i and j, respectively...
			d = F_matrix[i-1, j-1] + match_score # add the score
		else: # if sequence1 and sequence2 don't match at those positions...
			d = F_matrix[i-1, j-1] + mismatch_score # penalize alignment and choose best
		h = F_matrix[i,j-1] + gap_penalty # looks left for best score, add gap penalty is gap
		v = F_matrix[i-1,j] + gap_penalty # same as above but looking up
		best = F_matrix[i,j] # maximum score in F_matrix at i,j
		if best == d: # if the best score is from the diagonal
			trace_matrix[i,j] = "↖"
		elif best == h: # best from the left
			trace_matrix[i,j] = "←"
		else: # best from the right
			trace_matrix[i,j] = "↑"
# print(trace_matrix)


#========================================#
# Follow traceback to generate alignment #
#========================================#

# The aligned sequences are assumed to be strings named sequence1_aligment
# and sequence2_alignment in later code

# Start at bottom right corner
i = len(sequence1) # end up row
j = len(sequence2) # enf of column

# Make empty variables to put sequence
sequence1_aligment = ""
sequence2_alignment = ""

while i > 0 or j > 0: # keep looping as long as not 0, until reaches top left corner
	if i > 0 and j > 0 and trace_matrix[i,j] == "↖": # of trace_matrix is a diagonal
		sequence1_aligment = sequence1[i-1] + sequence1_aligment # Add both sequences to the alignments
		sequence2_alignment = sequence2[j-1] + sequence2_alignment
		i -= 1 # move up and then left in the matrix
		j -= 1
	elif j > 0 and trace_matrix[i,j] == "←": # if it is left arrow, add gap to sequence 1 and one to sequence 2
		sequence1_aligment = "-" + sequence1_aligment 
		sequence2_alignment = sequence2[j-1] + sequence2_alignment
		j -= 1
	elif i > 0 and trace_matrix[i,j] == "↑": 
		sequence1_aligment = sequence1[i-1] + sequence1_aligment # add letter to sequence 1 and add gap to sequence 2
		sequence2_alignment = "-" + sequence2_alignment
		i -= 1
	elif i == 0 and j > 0: # if top row
		sequence1_aligment = "-" + sequence1_aligment # add gap to sequence 1
		sequence2_alignment = sequence2[j-1] + sequence2_alignment
		j -= 1
	elif j == 0 and i > 0: # if left most column, add gap to seq 2
		sequence1_aligment = sequence1[i-1] + sequence1_aligment
		sequence2_alignment = "-" + sequence2_alignment
		i -= 1

#print("Sequence 1 alignment:", sequence1_aligment)
#print("Sequence 2 alignment:", sequence2_alignment)


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.
identity_alignment = ''
for i in range(len(sequence1_aligment)):
	if sequence1_aligment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '

#print(identity_alignment)


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

output = out_file

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_aligment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')

#=============================#
# Calculate sequence identity #
#=============================#

# number of gaps in each sequence
seq1_gaps = sequence1_aligment.count('-')
seq2_gaps = sequence2_alignment.count('-')

print("Number of gaps in sequence 1:", seq1_gaps)
print("Number of gaps in sequence 2:", seq2_gaps)

# percent identity for each sequence
matches = 0
for i in range(len(sequence1_aligment)):
    if sequence1_aligment[i] == sequence2_alignment[i]:
        matches += 1
percent_identity = (matches / len(sequence1_aligment)) * 100
print("Percent identity:", percent_identity)
#print(f"Percent identity: {percent_identity:.2f}%")

# Alignment score
alignment_score = F_matrix[-1, -1]
print("Alignment score:", alignment_score)




#======================#
# Print alignment info #
#======================#


# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score