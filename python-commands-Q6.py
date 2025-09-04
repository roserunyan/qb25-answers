#! /usr/bin/env python3

# Export gene features to BED format using Python
# Write a script that takes gencode.v46.basic.annotation.gtf and
import sys
my_gtf = open(sys.argv[1])
              
# Ignores a line if it startswith #
for line in my_gtf:
    if line[0].rstrip().startswith("#"):
        continue
    else:

# Only prints output for gene features (column 3)
        fields=line.rstrip().split("\t")
        #print(fields[2])
# Subtracts 1 from the start position to convert to zero-based coordinate system
        new_start=(int(fields[3]) -1 )

# Correctly parses gene name from the attribute (column 9)
        attributes = fields[8] #attributes is in column 9
        for attribute in attributes.strip().split(';'): # split by ; since each attribute is split this way
            if attribute.strip().startswith("gene_name"): #must strip because of whitespace and tabs, if it starts with gene_name
                gene_name=attribute.split('"') [1] #gets whatever is in quotes, which is the gene name we want, it is in position 1
                #print(gene_name)
# Prints chr, start, stop, gene name
                chr=fields[0]
                start=fields[3]
                stop=fields[4]
                print(chr + "\t" + "\t" + start + "\t" + stop + "\t" + gene_name)