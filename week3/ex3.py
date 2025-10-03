#!/usr/bin/env python3

# sample IDs (in order, corresponding to the VCF sample columns)
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31","A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

# open the VCF file
import sys
my_vcf = open(sys.argv[1]) # specify biallelic vcf as first arguement

with open("gt_long.txt", "w") as f1:
    for line in my_vcf:
        if line.startswith('#'):
            continue
        fields = line.rstrip('\n').split('\t')
        chrom = fields[0]
        pos  = fields[1]
        for sample in range(len(sample_ids)):
            sample_id=sample_ids[sample]
            sample_data=fields[9+sample]
            GT=sample_data.split(":")[0]
            if GT in ("0", "1"):
                print(f"{sample_id}\t{chrom}\t{pos}\t{GT}", file=f1)
            else:
                continue
