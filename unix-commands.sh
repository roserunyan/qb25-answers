#!/bin/bash

#### QUESTION 1 ####
#Calculate each of the following statistics by constructing a single command using one or more (linked together with a |) of the following commands: cut, grep, sort, uniq, wc
#How many features (lines)?
wc -l ce11_genes.bed #53935 lines

#How many features per chr? e.g. chrI, chrII
cut -f 1 ce11_genes.bed| uniq -c
#5460 chrI
#  12 chrM
#9057 chrV
#6840 chrX
##6299 chrII
#21418 chrIV
#4849 chrIII

#How many features per strand? e.g. +, -
cut -f 6 ce11_genes.bed| sort| uniq -c
#26626 -
#7309 +

#### QUESTION 3 ####
#Explore GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt using Unix
/Users/cmdb/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

#Which three SMTSDs (Tissue Site Detail) have the most samples?
cut -f 7 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort | uniq -c | sort | tail -n 3
# 867 Lung
#1132 Muscle - Skeletal
#3288 Whole Blood

#How many lines have “RNA”?
grep -c "RNA" GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
# 20017

#How many lines do not have “RNA”?
grep -vc "RNA" GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
# 2935

#### QUESTION 5 ####
#Explore ~/Data/References/hg38/gencode.v46.basic.annotation.gtf.gz using Unix

#How many entries are there for each feature type? Look at column 3 and be sure to skip any lines that begin with #
gunzip gencode.v46.basic.annotation.gtf.gz #unzip file
grep -v "#" gencode.v46.basic.annotation.gtf | cut -f 3 | uniq -c | wc -l #exclude lines with # | look at only column 3 | filter for unique types | count the number of lines
# 1763943

#How many lncRNA entries are on each chromosome?
grep "lncRNA" gencode.v46.basic.annotation.gtf | cut -f 1 | sort | uniq -c | sort -nr

# 13469 chr1
# 12332 chr2
# 9268 chr3
# 8483 chr6
# 8385 chr5
# 7867 chr12
# 7677 chr4
# 7627 chr7
# 7598 chr8
# 7428 chr15
# 6937 chr16
# 6720 chr17
# 6464 chr11
# 6251 chr10
# 5684 chr14
# 5515 chr19
# 5398 chr9
# 4405 chr13
# 4092 chr18
# 3961 chr20
# 3365 chrX
# 3284 chr21
# 3275 chr22
# 1176 chrY
