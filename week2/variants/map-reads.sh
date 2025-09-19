#!/bin/bash

for sample in A01_01 A01_02 A01_03 A01_04 A01_05 A01_06
do
    echo $sample #to use a variable, prefix with $
    ls -l ~/Data/BYxRM/fastq/$sample.fq.gz
    #alignment
    bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/$sample.fq.gz > $sample.sam
    # sort
    samtools sort -o $sample.bam $sample.sam
    # index
    samtools index $sample.bam
done