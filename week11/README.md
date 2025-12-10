# Week 11 Assignment
## Step 1.1
1. How many 100bp reads are needed to sequence a 1Mbp genome to 3x coverage?
- 3x coverage= 3 x 1Mb genome = 3Mb
- 3Mb / 100bp reads = **30,000 100 bp reads**

## Steps 1.4
1. In your simulation, how much of the genome has not been sequenced (has 0x coverage)?
- 49,986
2. How well does this match Poisson expectations? How well does the normal distribution fit the data?
- It matches Poisson expectations pretty well with just a few gaps and it matches the normal distribution pretty well

## Steps 1.5
1. In your simulation, how much of the genome has not been sequenced (has 0x coverage)?
- 73
2. How well does this match Poisson expectations? How well does the normal distribution fit the data?
- It matches a lot better than 3x coverage, just.a few gaps between the Poisson and is slightly off center from the normal distribution.

## Steps 1.6
1. In your simulation, how much of the genome has not been sequenced (has 0x coverage)?
- 12
2. How well does this match Poisson expectations? How well does the normal distribution fit the data?
- This fits almost exactly

## Step 2.4
```dot -Tpng debruijn.dot -o ex2_digraph.png```

## Step 2.5
1. Assume that the maximum number of occurrences of any 3-mer in the actual genome is five. Using your graph from Step 2.4, write one possible genome sequence that would produce these reads.
- 
## Step 2.6
1. what would it take to accurately reconstruct the sequence of the genome?
- We would need high coverage reads to be very accurate, as well as longer reads. Since we can see that multiple paths can lead to the same reads, we need this higher coverage and longer reads to make the path more clear.
