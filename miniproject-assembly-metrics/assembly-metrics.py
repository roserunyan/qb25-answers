#! /usr/bin/env python3

import sys
import fasta

my_file=open(sys.argv[1])
contigs = fasta.FASTAReader(my_file)

ident_count=0
seq_sum=0
contig_len=[]
for ident, sequence in contigs: #for every ident and sequence for each contig read by the fastareader, it knows the first object is ident and the second is sequence
    ident_count+=1
    seq_len=len(sequence)
    seq_sum+=seq_len
    contig_len.append(seq_len)

average= seq_sum / ident_count

print(f"Number of contigs: {ident_count}, Total length: {seq_sum}, Average length: {average}")

contig_len.sort(reverse=True)
#print(contig_len)

half_len= seq_sum / 2
contig_count=0
for contig in contig_len:
    contig_count+= contig
    if contig_count >= half_len:
        break
print("sequence length of the shortest contig at 50% of the total assembly length:", contig)

# for contig in contig_len:
#     if 







