# Week 2 Exercise 5
**Hisat2 command** \
``hisat2 -p 4 -x ../genomes/sacCer3 -U ../rawdata/SRR10143769.fastq > rna.sam``

**Samtools commands** \
``samtools sort -o rna.bam rna.sam`` \
``samtools index rna.bam``

**Description**
The end of the genes seem to have the most coverage.