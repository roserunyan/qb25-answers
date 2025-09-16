#!/bin/bash

# Make 1mb windows of hg16
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed

# Count how many genes are in each 1mb window in hg16
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed > hg16-kc-count.bed

# How many genes are in hg19?
wc hg19-kc.bed
# Answer: 80270 genes in hg19

# How many genes in hg19 but not hg16?
bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc
# Answer: 42717 in hg19 that are not in hg16

#Why are some genes in hg19 and not in hg16?
#Answer: Since hg16, the genome has been updated to include newly discovered genes or unsequenced regions.

# How many genes are in hg16?
wc hg16-kc.bed
# Answer: 21365 genes in hg16

# How many genes in hg16 but not hg19?
bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | wc
# Answer: 3460 in hg16 that are not in hg19

#Why are some genes in hg16 and not in hg19?
#Answer: Since hg16, the genome has been improved, so these may be from mistakes in annotation or sequence assembly that have been corrected in the newer assembly.

