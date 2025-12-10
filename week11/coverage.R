##########################
### Week 11 Assignment ###
##########################

# Step 1.3- plot the histogram and probability distributions
library(ggplot2)

# Read in coverage file
coverage <- read.table("coverage.txt", colClasses = "numeric")
coverage <- coverage[coverage != ""]              # remove empty lines
coverage <- as.numeric(coverage)  
df <- data.frame(coverage = coverage)

# overlay with Poisson distribution and Normal distribution
lambda <- 3
mean_val <- 3
sd_val <- sqrt(3)

## histogram of coverage and distributions
# histogram
p <- ggplot(data.frame(coverage), aes(x = coverage)) +
  geom_histogram(fill = "pink") +
  
  # Poisson curve- I got this from chatGPT- finds the Poisson probability of seeing coverage = x, convert to counts to match histogram
  stat_function(
    aes(color = "Poisson Distribution"),
    fun = function(x) dpois(round(x), lambda) * length(coverage),
    size = 1.2
  ) +
  
  # plot normal distribution- probability density for each coverage possible, converts to counts
  stat_function(
    aes(color = "Normal Distribution"),
    fun = function(x) dnorm(x, mean = mean_val, sd = sd_val) * length(coverage),
    size = 1.2
  ) +
  
  scale_color_manual(
    values = c(
      "Poisson Distribution" = "purple",
      "Normal Distribution" = "darkgreen"
    )
  ) +
  
  labs(
    title = "Genome Coverage Distribution",
    x = "Coverage",
    y = "Number of Positions",
    color = "Distribution"
  ) +
  
  theme_classic()

p

# save histogram 
ggsave("~/qb25-answers/week11/ex1_3x_cov.png", plot = p)


