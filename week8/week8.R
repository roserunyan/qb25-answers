### Exercise 1: Data preprocessing ###
# Step 1.1: Loading data and importing libraries
# load libraries
library(DESeq2)
library(tidyverse)
library(broom)

setwd("~/qb25-answers/week8")

# read in file
counts_df <- read_delim("gtex_whole_blood_counts_downsample.txt")
metadata_df <- read_delim("gtex_metadata_downsample.txt")

# move gene names as column name
counts_df <- column_to_rownames(counts_df, var = "GENE_NAME")
metadata_df <- column_to_rownames(metadata_df, var = "SUBJECT_ID")

# Step 1.2: Create a DESeq2 object
# check if column names in counts match row names in metadata
colnames(counts_df) == rownames(metadata_df)

# load data into deseq2
dds <- DESeqDataSetFromMatrix(countData=counts_df,
                              colData=metadata_df,
                              design = ~ SEX + AGE + DTHHRDY) 

# Step 1.3: Normalization and PCA
vsd <- vst(dds)

# plot PCA
plotPCA(vsd, intgroup="SEX")
ggsave("~/qb25-answers/week8/pca_sex.png")

plotPCA(vsd, intgroup="AGE")
ggsave("~/qb25-answers/week7/pca_age.png")

plotPCA(vsd, intgroup="DTHHRDY")
ggsave("~/qb25-answers/week7/pca_dthhrdy.png")

# What proportion of variance in the gene expression data is explained by each of the first two principal components? 
  # PCA1: 48%
  # PCA2: 7%
# Which principal components appear to be associated with which subject-level variables? 
  # PCA1: DTHHRDY- cause of death
  # PCA2: May be sex, but since the variance is so low, it is not very clear
# Interpret these patterns in your own words and record your answers as a comment in your code.

### Exercise 2: Perform differential expression analysis ###
# Step 2.1: Perform a “homemade” test for differential expression between the sexes
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata_df, vsd_df)

# test for differential expression of the gene WASH7P
m1 <- lm(formula = WASH7P ~ SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
# Does WASH7P show significant evidence of sex-differential expression (and if so, in which direction)? 
# No, this gene does not have differential gene expression because the p-value is higher than 0.05 (~0.32).

# Now repeat your analysis for the gene SLC25A47. 
m2 <- lm(formula = SLC25A47 ~ SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
# Does this gene show evidence of sex-differential expression (and if so, in which direction)? Explain your answer.
# Yes, this gene does have significant expression with a p value of ~0.03. Based on the positive estimate of 0.5, it is slightly upregulated in males.

# Step 2.2: Perform differential expression analysis “the right way” with DESeq2
dds <- DESeq(dds)

# Step 2.3: Extract and interpret the results for sex differential expression
res <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")


# How many genes exhibit significant differential expression between males and females at a 10% FDR?
res %>%
  filter(padj < 0.1) %>%
  nrow()
# 262

# load the mappings of genes to chromosomes, 
mappings_df <- read_delim("gene_locations.txt")

# Merge these data with your differential expression results 
# using the left_join() function, setting by = GENE_ID (i.e., the shared column on which you want to join). 
res_mappings <- left_join(res, mappings_df, by = "GENE_NAME")

# Order the merged tibble by padj, from smallest to largest.
res_mappings_ordered <- res_mappings %>% arrange(padj)

# Which chromosomes encode the genes that are most strongly upregulated in males versus females, respectively?
# Y chromosomes encodes genes most upregulated in males and X chromosomes encodes for most upregulated in female.

# Are there more male-upregulated genes or female-upregulated genes near the top of the list? 
# More male upregulated genes at the top of the list. I know this because they have positive logfold change.

# Interpret these results in your own words.
# These results make sense since females do not have Y chromosomes. Any genes encoded by the Y chromosomes will not be present in females, so in theory they would all be upregulated in males.

# Examine the results for the two genes (WASH7P and SLC25A47) that you had previously tested with the basic linear regression model in step 2.1. 
# Are the results broadly consistent?
# WASH7p is also not differentially expression, consistent with my previous results.
# SLC25A47 is upregulated in males, just as before. However, this time the logfold change is much greater, showing it has a larger difference in males and females and it is more significant.

# Add a short reflection (2–3 sentences) on how your analysis illustrates the trade-off between false positives and false negatives. 
# By using more stringent filters, we decrease our rate of false positives, but in doing so we may also be throwing away some genes that are actually slightly significantly more highly expressed, increasing the rate of false positives.
# For example, if we make the FDR threshold just 1%, we can be much more confident that we are reducing the number of false positives. But if there are any genes slightly higher expressed, they will be thrown out and missed, resulting in more false negatives.
# If we increase to a less stringent threshold like 20% we may keep more of those true positives and reduce false negatives, but have a higher rate of false positives.

# Briefly comment on how sample size and effect size might influence the power of your analysis to detect truly differentially expressed genes.
# More sample sizes provide more power to detect true differences in gene expression because they decrease the variability between replicates. 
# Having a higher effect size helps you be more sure that the significant difference is not noise or a false positive.
# For example, orignally, SLC25A47 has a logfoldchange of just 0.5, so I was not super confident it was much more highly expressed in males. But after DESeq2, this increased to 3, which gave me more confidence it was a truly differntially expressed gene.

# Step 2.4: Extract and interpret the results for differential expression by death classification
res_death <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")

# How many genes are differentially expressed according to death classification at a 10% FDR?
res_death %>%
  filter(padj < 0.1) %>%
  nrow()
# 16069

# Step 2.5: Estimating a false positive rate under the null hypothesis
metadata_df$SEX <- sample(metadata_df$SEX, replace = FALSE)

dds_permuted <- DESeqDataSetFromMatrix(countData=counts_df,
                              colData=metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)
dds_permuted <- DESeq(dds_permuted)

# How many genes appear “significant” in this permuted analysis at a 10 % FDR? 
res_permuted <- results(dds_permuted, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")

res_permuted %>%
  filter(padj < 0.1) %>%
  nrow()
# 113

# Compare this number to the count from your real (non-permuted) analysis. 
# What does this suggest about how well the FDR threshold controls the expected rate of false discoveries in large-scale RNA-seq experiments?
# 113 genes are still sigificant in this dataset compared to 262 from before. This number if higher than I expected, given these are all false positives. 
# Since the FDR threshold controls for the number of expected false positives, it will not get ride of all of them, especially in a large dataset. It does not expect all of them to be false positives, so it will not get rid of all of these, even though they are all false positives.

### Exercise 3: Visualization ###
ggplot(data = res, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color = padj < 0.1 & abs(log2FoldChange) > 1))

# Output this plot to a .png that you will upload with your assignment.
ggsave("~/qb25-answers/week8/ex3.png")
