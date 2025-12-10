##########################
### Week 11 Assignment ###
##########################

#### Step 1.3- plot the histogram and probability distributions ####
library(ggplot2)

# Read in coverage file
coverage <- read.table("coverage3.txt", colClasses = "numeric")
coverage <- coverage[coverage != ""]              # remove empty lines
coverage <- as.numeric(coverage)  
df <- data.frame(coverage = coverage)

# overlay with Poisson distribution and Normal distribution
lambda <- 3
mean_val <- 3
sd_val <- sqrt(3)

## histogram of coverage and distributions ####
# histogram
p_3 <- ggplot(data.frame(coverage), aes(x = coverage)) +
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

p_3

# save histogram 
ggsave("~/qb25-answers/week11/ex1_3x_cov.png", plot = p)

# find number of 0 occurances
num_zeros <- sum(coverage == 0)
num_zeros


#### Step 1.5- plot the histogram and probability distributions
library(ggplot2)

# Read in coverage file
coverage10 <- read.table("coverage10.txt", colClasses = "numeric")
coverage10 <- coverage10[coverage10 != ""]              # remove empty lines
coverage10 <- as.numeric(coverage10)  
df_10 <- data.frame(coverage10 = coverage10)

# overlay with Poisson distribution and Normal distribution
lambda_10 <- 10
mean_10 <- 10
sd_10 <- sqrt(10)

## histogram of coverage and distributions
# histogram
p_10 <- ggplot(data.frame(coverage10), aes(x = coverage10)) +
  geom_histogram(fill = "pink", binwidth = 1, color="black") +
  
  # Poisson curve- I got this from chatGPT- finds the Poisson probability of seeing coverage = x, convert to counts to match histogram
  stat_function(
    aes(color = "Poisson Distribution"),
    fun = function(x) dpois(round(x), lambda_10) * length(coverage10),
    size = 1.2
  ) +
  
  # plot normal distribution- probability density for each coverage possible, converts to counts
  stat_function(
    aes(color = "Normal Distribution"),
    fun = function(x) dnorm(x, mean = mean_10, sd = sd_10) * length(coverage10),
    size = 1.2
  ) +
  
  scale_color_manual(
    values = c(
      "Poisson Distribution" = "purple",
      "Normal Distribution" = "darkgreen"
    )
  ) +
  
  labs(
    title = "Genome Coverage Distribution with 10X coverage",
    x = "Coverage",
    y = "Number of Positions",
    color = "Distribution"
  ) +
  
  theme_classic()

p_10

# save histogram 
ggsave("~/qb25-answers/week11/ex1_10x_cov.png", plot = p_10)

# find number of 0 occurances
num_zeros <- sum(coverage10 == 0)
num_zeros

#### Step 1.6- plot the histogram and probability distributions
# Read in coverage file
coverage30 <- read.table("coverage30.txt", colClasses = "numeric")
coverage30 <- coverage30[coverage30 != ""]              # remove empty lines
coverage30 <- as.numeric(coverage30)  
df_30 <- data.frame(coverage30 = coverage30)

# overlay with Poisson distribution and Normal distribution
lambda_30 <- 30
mean_30 <- 30
sd_30 <- sqrt(30)

## histogram of coverage and distributions
# histogram
p_30 <- ggplot(data.frame(coverage30), aes(x = coverage30)) +
  geom_histogram(fill = "pink", binwidth = 1, color="black") +
  
  # Poisson curve- I got this from chatGPT- finds the Poisson probability of seeing coverage = x, convert to counts to match histogram
  stat_function(
    aes(color = "Poisson Distribution"),
    fun = function(x) dpois(round(x), lambda_30) * length(coverage30),
    size = 1.2
  ) +
  
  # plot normal distribution- probability density for each coverage possible, converts to counts
  stat_function(
    aes(color = "Normal Distribution"),
    fun = function(x) dnorm(x, mean = mean_30, sd = sd_30) * length(coverage30),
    size = 1.2
  ) +
  
  scale_color_manual(
    values = c(
      "Poisson Distribution" = "purple",
      "Normal Distribution" = "darkgreen"
    )
  ) +
  
  labs(
    title = "Genome Coverage Distribution with 30X coverage",
    x = "Coverage",
    y = "Number of Positions",
    color = "Distribution"
  ) +
  
  theme_classic()

p_30

# save histogram 
ggsave("~/qb25-answers/week11/ex1_30x_cov.png", plot = p_30)

# find number of 0 occurances
num_zeros <- sum(coverage30 == 0)
num_zeros


