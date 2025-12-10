#! /usr/bin/env python3
# import modules
import random
import math
import matplotlib.pyplot as plt
from scipy.stats import poisson, norm

# set variables
genomesize = 1000000
readlength = 100
coverage = 30

num_reads = int(genomesize * coverage / readlength)

## use an array to keep track of the coverage at each position in the genome
genomecoverage = [0] * genomesize

for i in range(num_reads):
  startpos = random.randint(0,genomesize-readlength) # got this from chatgpt to generate random integers
  endpos = startpos + readlength
  # iterate through each position in read
  for pos in range(startpos,endpos):
    genomecoverage[pos] += 1

## get the range of coverages observed
maxcoverage = max(genomecoverage)
xs = list(range(0, maxcoverage+1))

## Get the poisson pmf at each of these
lmbda = coverage
poisson_estimates = poisson.pmf(xs, lmbda)

## Get normal pdf at each of these (i.e. the density between each adjacent pair of points)
stddev = math.sqrt(coverage)
normal_estimates = norm.pdf(xs, loc=coverage, scale=stddev)

# Save the coverage to a text file
with open("coverage30.txt", "w") as f:
    for cov in genomecoverage:
        f.write(f"{cov}\n")