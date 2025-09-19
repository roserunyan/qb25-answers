# Week 2 Assignment

## Exercise 1
**Bowtie command** \
``bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam`` \

**Samtools commands** \
samtools sort -o A01_01.bam A01_01.sam \
samtools index A01_01.bam \

**Stats** \
samtools idxstats A01_01.bam > A01_01.idxstats

## Exercise 2
**Interpretation** \
Samples 1,3 and 4 all have more variation and are all the R genotype. whereas samples 2,5, and 6 have less variation. This means the reference is likely the B genotype or more closely related.