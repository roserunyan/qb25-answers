#!/usr/bin/env python3

import sys
my_vcf = open(sys.argv[1]) # specify biallelic vcf as first arguement

# Allele frequency spectrum
# Extract the allele frequency of each variant and output it to a new file called AF.txt 
# extract the read depth of each variant site in each sample and output it to a new file called DP.txt
with open("AF.txt", "w") as f1, open("DP.txt", "w") as f2:
    for line in my_vcf:
        if line.startswith('#'):
            continue
        fields = line.rstrip('\n').split('\t')
        INFO = fields[7].split(';')
        AF_INFO = INFO[3]
        AF = AF_INFO[3:]
        print(AF, file=f1)
        FORMAT = fields[9:19]
        for sample in FORMAT:
            format_split=sample.split(':')
            DP=format_split[2]
            print(DP, file=f2)
