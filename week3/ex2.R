# Load libraries
library(tidyverse)

### STEP 2.2 ###
# Read in file
setwd("~/qb25-answers/week3")
df_AF <- read.table("AF.txt", header = FALSE, col.names= "AF")

ggplot(df_AF, aes(AF)) +
  geom_histogram(bins=11, fill="blue", color="white") +
  labs(
      title= "Allele Frequency per Variant",
      x = "Allele Frequency",
      y = " Number of Variants"
  ) +
  theme_minimal()

ggsave("~/qb25-answers/week3/AF.png", width = 8, height = 4)

# Question 2.1: The most common allele frequency is around 0.5, with it dropping to each end.
# This means that for most variants, the alternative allele makes up half of the alleles in the population.
# This is expected since these variants are from F1s that were produced from a cross between the reference 
# strain and an alternative strain.

### STEP 2.3 ###
#Read in file
df_DP <- read.table("DP.txt", header = FALSE, col.names= "DP")

# Plot a histogram showing the distribution of read depth at each variant across all samples
ggplot(df_DP, aes(DP)) +
  geom_histogram(bins=21, fill="magenta", color="black") +
  xlim(0, 20) +
  labs(
    title= "Number of Samples per Read Depth",
    x = "Read Depth",
    y = " Number of Samples"
  ) +
  theme_minimal()

ggsave("~/qb25-answers/week3/DP.png", width = 8, height = 4)

# Question 2.2: This represents how many samples had each number of reads.
# Most of the samples have a depth of around 2-5 and this makes sense because the recombinants
# in this study were sequenced with low coverage.