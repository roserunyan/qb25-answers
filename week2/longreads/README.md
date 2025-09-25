## Exercise 4
**minimap2 command** \
``minimap2 -ax map-ont ../genomes/sacCer3.fa ../rawdata/ERR8562478.fastq > longreads.sam``

**samtools commands** \
``samtools sort -o longreads.bam longreads.sam`` \
``samtools index longreads.bam``

**Stats** \
``samtools idxstats longreads.bam > longreads.idxstats``