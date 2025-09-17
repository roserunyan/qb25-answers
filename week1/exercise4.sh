#!/bin/bash

# Which gene as the most snps?
bedtools intersect -a hg19-kc.bed -b snps-chr1.bed -c | sort -k5,5n | tail
# Answer: ENST00000490107.6_7 with 5445 SNPs
# Describe the gene
# Systematic name: ENST00000490107.6_7 
# human readable name: SMYD3
# position: chr1:245,912,649-246,670,581
# size: 757,933
# exon count: 12
# It may have a lot of SNPs simply because the gene is so large.

# Create subset of SNPs
bedtools sample -i snps-chr1.bed -n 20 -seed 42 > snps_subset.bed

# sort snps subset
bedtools sort -i snps_subset.bed > snps_subset_sorted.bed

# sort hg19-kc
bedtools sort -i hg19-kc.bed > hg19-kc-sorted.bed

# bedtools closest
bedtools closest -a snps_subset_sorted.bed -b hg19-kc-sorted.bed -d -t first > closest.bed

# How many SNPs are inside of a gene?
# Answer: 14 (I just counted the number of 0s)

# What is the range of distances for the ones outside a gene?
# 4407-22944