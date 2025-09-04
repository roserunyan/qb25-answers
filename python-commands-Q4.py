#! /usr/bin/env python3

#Transform GTEx data using Python
#Write a script that extracts expression values for the first gene (DDX11L1) which is stored on a single line spread across more than 17,000 columns and transposes the data so that the expression in each sample is stored on a separate line.
#Open the expression data file GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct
import sys
my_file = open(sys.argv[1])

#Skip the first two lines using .readline()
_ = my_file.readline()
_ = my_file.readline()

#Read the next header line and save the fields after splitting
header = my_file.readline().rstrip().split("\t")
#print("Header:", header)

#Read the next data line and save the fields after splitting
data = my_file.readline().rstrip().split("\t") #gene of interest, one line
#print("Data:", data)

#Create a dictionary by looping through the fields, using header[i] as the key to store data[i] as the value
exp_dict = {}

for i in range(len(header)): #they are same length, so can use header for the length
    exp_dict[header[i]] = data[i] #for each index in header, the index in data in the same position corresponds
#print(exp_dict)

#Open the metadata file GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
meta_data = open(sys.argv[2])
for line in meta_data:
    fields = line.rstrip().split("\t")
#If the SAMPID in the first column is present in the dictionary, print out the SAMPID, expression, and SMTSD e.g.
    if fields[0] in exp_dict:
       print(fields[0] + "\t" + data[i] + "\t" + fields[6])
    
#GTEX-1117F-0226-SM-5GZZ7	0.02522	Adipose - Subcutaneous
#GTEX-1117F-0426-SM-5EGHI	0.02522	Muscle - Skeletal
#GTEX-1117F-0526-SM-5EGHJ	0.02522	Artery - Tibial
#GTEX-1117F-0626-SM-5N9CS	0.02522	Artery - Coronary
#GTEX-1117F-0726-SM-5GIEN	0.02522	Heart - Atrial Appendage