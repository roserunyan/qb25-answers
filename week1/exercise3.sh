#!/bin/bash
# Subset active and repressed into separate files for nhek and nhlf
grep 1_Active nhek.bed > nhek-active.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed
grep 1_Active nhlf.bed > nhlf-active.bed
grep 12_Repressed nhlf.bed > nhlf-repressed.bed

# Test where there is any overlap between 1_Active and 12_Repressed in a given condition (aka mutually exclusive)
bedtools intersect -a nhek-active.bed -b nhek-repressed.bed
bedtools intersect -a nhlf-active.bed -b nhlf-repressed.bed

# regions that are active in NHEK and NHLF
bedtools intersect -u -a nhek-active.bed -b nhlf-active.bed | wc
# Features: 11608

# regions that are active in NHEK but not active in NHLF
bedtools intersect -v -a nhek-active.bed -b nhlf-active.bed | wc
#Features: 2405

#Do these two numbers add up to the original number of lines in nhek-active.bed?
# Yes, they add up to 14013

# Effect of using the arguments -f 1, -F 1, and -f 1 -F 1 when comparing -a nhek-active.bed -b nhlf-active.bed
bedtools intersect -f 1 -a nhek-active.bed -b nhlf-active.bed | head -n 1
#chr1	25558413	25559413
bedtools intersect -F 1 -a nhek-active.bed -b nhlf-active.bed | head -n 1
#chr1	19923013	19924213
bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf-active.bed | head -n 1
#chr1	1051137	1051537

# How does the relationship between the NHEK and NHLF chromatin state change as you alter the overlap parameter?
# Answer: with -f1,  the active regions overlap in 100% of nhek, with -F1, they overlap in 100% of nhfl, and with -f1 -F1, they overlap in 100% of both

# Active in NHEK, Active in NHLF
bedtools intersect -a nhek-active.bed -b nhlf-active.bed | head -n 1
# chr1	19923013	19924213
# All of the conditions in this region are active

# Active in NHEK, Repressed in NHLF
bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed | head -n 1
# chr1	1981140	1981540
# The conditions are all mixed with repressed, weak enhancer, strong enhancer, active, insulator

# Repressed in NHEK, Repressed in NHLF
bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed | head -n 1
# chr1	11537413	11538213
# All of the conditions are either repressed or heterochromatin






