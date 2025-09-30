#!/bin/bash

#Download the file and extract it with:
tar -xzvf BYxRM_bam.tar.gz

# Index each of your bam files with samtools index
samtools index -M BYxRM_bam/*.bam
# How many aligned reads does each BAM file contain? (Hint: See the -c flag for samtools view). 
for sample in ls *.bam
do
    samtools view -c "$sample" >> read_counts.txt
done

# Generate a list of bam file names (one bam file per line) and name it bamListFile.txt
for sample in *.bam
do
    echo $sample >> bamListFile.txt
done

# run FreeBayes to discover variants 
freebayes -f ../../week2/genomes/sacCer3.fa -L bamListFile.txt --genotype-qualities -p 1 > unfiltered.vcf

# filter the variants based on their quality score and remove sites where any sample had missing data
vcffilter -f "QUAL > 20" -f "AN > 9" unfiltered.vcf > filtered.vcf
