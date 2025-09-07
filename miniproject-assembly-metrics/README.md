# My Project
## Assembling worm genome

## Genome files used
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz
    - file size: 115M
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz
    - file size: 121M
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz
    - file size: 141M
- https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz
    - file size: 127M

## Instructions
- Use assembly-metrics.py to print the number of contigs, the total length, and the average length
- This requires downloading the fasta.py file
    - wget https://raw.githubusercontent.com/bxlab/cmdb-quantbio/refs/heads/main/resources/code/fasta.py
- Download the genome files above by running getGenomes.sh
    - ./getGenomes.sh
- Run the assembly-metrics.py file
    - ./assembly-metrics.py file [genome_file.fa]



## Results
- PRJNA248909
    - Number of contigs: 1591, Total length: 118549266, Average length: 74512.42363293526
    - sequence length of the shortest contig at 50% of the total assembly length: 1522088
- PRJNA248911
    - Number of contigs: 912, Total length: 124541912, Average length: 136559.11403508772
    - sequence length of the shortest contig at 50% of the total assembly length: 1765890
- PRJNA53967
    - Number of contigs: 3670, Total length: 145442736, Average length: 39630.17329700272
    - sequence length of the shortest contig at 50% of the total assembly length: 435512
- PRJNA577507
    - Number of contigs: 187, Total length: 130480874, Average length: 697758.6844919786
    - sequence length of the shortest contig at 50% of the total assembly length: 21501900