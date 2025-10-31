### Exercise 1: PCA analysis ###
library(tidyr)
library(dplyr)
library(palmerpenguins)
library(matrixStats)
library(ggplot2)

## Step 1.1: Loading and filtering the data
# Begin by loading the data into R
setwd("~/qb25-answers/week7")
read_matrix <- as.matrix(read.table("read_matrix.tsv"))

# For the PCA analysis you will only want to use the most variable genes. 
# Find the standard deviation of each gene
stdev_genes <- rowSds(read_matrix)

# order the genes based on stdev and put in ascending order
top500_list <- order(stdev_genes, decreasing=TRUE) [1:500]

# extract the top 500 genes from the orignal dataset
top500_genes <- read_matrix[top500_list, ,drop=FALSE ]

## Step 1.2: Run the PCA Analysis
# invert your matrix 
top500_genes_t <- (t(top500_genes))

# To perform PCA, you will use the function prcomp. 
pca_results <- prcomp(top500_genes_t)
View(pca_results)

# access first and second PC coordinates for first sample
pca_results$x[1,1:2]
# see amount of variance explained by each principal component
pca_results$sdev

## Step 1.3: Plot the first two PCs and plot the amount of variance explained for each PC
# Plot each sample using its first two PC coordinates. 
# make vector with list of sample names
sample <- rownames(top500_genes_t)

# create a new tibble (dataframe) with columns corresponding to the first and second PCs as well as the sample names 
# split sample names into two columns,tissue and replicate
pca_data <- tibble(PC1=pca_results$x[,1], PC2=pca_results$x[,2], sample=sample) %>%
  separate(sample, into=c("tissue", "replicate"), sep="_") %>%
  mutate(replicate=as.factor(replicate))

# Make sure to include a legend and if you can, 
# use color to denote tissue and point shapes to denote replicate number. 
ggplot(pca_data, aes(x=PC1, y=PC2, color=tissue, shape=replicate)) +
  geom_point(size=2) +
  labs(title="PCA of Top 500 Variable Genes")

# Save this plot
ggsave("~/qb25-answers/week7/ex1.3.png")

# Fix normalization problem
norm_top_genes <- scale(top500_genes_t)
pca_results_norm <- prcomp(norm_top_genes)

pca_data_norm <- tibble(PC1=pca_norm$x[,1], PC2=pca_norm$x[,2], sample=sample) %>%
  separate(sample, into=c("tissue", "replicate"), sep="_") %>%
  mutate(replicate=as.factor(replicate))

# plot the amount of variance explained by each PC as a bar chart. label your axes.
# PCA analysis on normalized data
pca_summary <- tibble(PC=seq(1, length(pca_results_norm$sdev)), sd=pca_results_norm$sdev) %>%
  mutate(norm_var = sd^2 / sum(sd^2))

#screen plot
ggplot(pca_summary, aes(x=PC, y=norm_var)) +
  geom_line() +
  geom_point() +
  labs(title= "Amount of Variance Explained by PCs", y="Percent variance explained")

# Save this plot to turn in.
ggsave("~/qb25-answers/week7/ex1.3_scree.png")
