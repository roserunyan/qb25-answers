# Load libraries
library(tidyverse)

### STEP 3.3 ###
# Read in file
setwd("~/qb25-answers/week3")
df_GT <- read.table("gt_long.txt", header = FALSE, col.names=c("sample", "chr", "pos", "gt"))

# For a chromosome chrII of sample A01_62, create a figure where the x axis is the position 
# and colors indicate whether the genotype was a 0 or a 1. 
# Make sure to convert the genotype to a factor variable.
s62 <- subset(df_GT, sample == "A01_62")
s62_chr2 <- subset(s62, chr == "chrII")
s62_chr2$gt <- factor(s62_chr2$gt)

ggplot(s62_chr2, aes(x = pos, y= 0, color = gt)) +
  geom_point() +
  scale_color_manual(values = c("0" = "purple", "1" = "green")) +
  labs(
    title = "Sample A01_62 Chromosome 2 Genotype",
    x = "Genomic Position",
    y = NULL,
    color = "Genotype"
  ) +
  theme_minimal()

ggsave("~/qb25-answers/week3/A01_62_chr2.png", width = 8, height = 4)

# Question 3.2: Do you notice any patterns? What do the transitions indicate?
# I notice that the genome begins as 1, then is 0 in the middle, then is 1 again. Each color represents 
# a different genotype inherited from the parent and the switch indicates regions where recombination occurred.

### STEP 3.4 ###
# Use facet_grid to plot all chromosomes for sample A01_62. 
# Use the scales = "free_x" and space = "free_x" options to allow for different x-axis scales for different chromosomes. 
s62$gt <- factor(s62$gt) 

ggplot(s62, aes(x = pos, y = 0, color = gt)) +
  geom_point(size = 0.5) +
  scale_color_manual(values = c("0" = "purple", "1" = "green")) +
  facet_grid(~ chr, scales = "free_x", space = "free_x") +
  labs(
    title = "Sample A01_62 Genotypes",
    x = "Genomic Position",
    y = NULL,
    color = "Genotype"
  ) +
  theme_minimal()

ggsave("~/qb25-answers/week3/A01_62.png", width = 8, height = 4)

# Extend your plot to consider all samples. Note that different samples do not need their own facets, 
# but can simply be arranged along the y axis (which can accept variables that are not numeric!).
df_GT$gt = factor(df_GT$gt)
df_GT$sample = factor(df_GT$sample)

ggplot(df_GT, aes(x = pos, y = sample, color = gt)) +
  geom_point(size = 1) +
  #geom_tile(height = 0.8) +
  #facet_grid(~ chr, scales = "free_x", space = "free_x") +
  scale_color_manual(values = c("0" = "purple", "1" = "green")) +
  labs(
    title = "A01 Sample Genotypes",
    x = "Genomic Position",
    y = "Sample",
    color = "Genotype"
  ) +
  theme_minimal()

ggsave("~/qb25-answers/week3/A01_GT.png", width = 8, height = 4)
