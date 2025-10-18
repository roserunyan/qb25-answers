# load libraries
library(tidyverse)
library(broom)

# Exercise 1: Wrangle the data
# Step 1.1 — Load DNMs
# Load aau1043_dnm.csv into a tibble.
dnm <- read_csv("aau1043_dnm.csv", col_names = TRUE)

# Step 1.2 — Count DNMs by parental origin per proband
# Create a per-proband summary with counts of maternally and paternally inherited DNMs. Ignore DNMs without a specified parent of origin.
dnm_counts <- dnm %>%
  group_by(Proband_id) %>%
  summarize("Paternal"= sum(Phase_combined == "father", na.rm=TRUE), "Maternal" = sum(Phase_combined == "mother", na.rm=TRUE))
  
# Step 1.3 — Load parental ages
# Load aau1043_parental_age.csv.
par_age<- read_csv("aau1043_parental_age.csv", col_names = TRUE)

# Step 1.4 — Merge counts with ages
# Join the two tibbles by proband ID.
par_age_counts <- inner_join(par_age, dnm_counts)

# Exercise 2: Fit and interpret linear regression models with R
# Step 2.1 — Visualize relationships
# 1) Create a scatter plot of the count of maternal DNMs vs. maternal age
ggplot(data = par_age_counts, aes(x= Mother_age, y = Maternal)) +
  geom_point() +
  labs( 
    title = "Maternal Age vs Number of Mutations",
    x = "Age of Mother",
    y = "Number of DNMs"
  )

# save as ex2_a.png
ggsave("~/qb25-answers/week5/ex2_a.png", width = 8, height = 4)

# 2) Create a scatter plot of the count of paternal DNMs vs. paternal age 
ggplot(data = par_age_counts, aes(x= Father_age, y = Paternal)) +
  geom_point() +
  labs( 
    title = "Paternal Age vs Number of Mutations",
    x = "Age of Father",
    y = "Number of DNMs"
  )

# save as ex2_b.png
ggsave("~/qb25-answers/week5/ex2_b.png", width = 8, height = 4)

# Step 2.2 — OLS: maternal age vs. maternal DNMs
# Fit a simple linear regression model relating maternal age to the number of maternal de novo mutations.
lm(data = par_age_counts, formula = Maternal ~ 1 + Mother_age ) %>%
  summary()

# Step 2.3 — OLS: paternal age vs. paternal DNMs
# Repeat the step above but for paternal age vs. paternal DNMs.
lm(data = par_age_counts, formula = Paternal ~ 1 + Father_age ) %>%
  summary()

# Step 2.4 — Predict for a 50.5-year-old father
# Use the paternal regression model to predict the expected number of paternal DNMs for a father of age 50.5. You are welcome to do this manually or using a built-in function, but show your work in README.md.
y=beta0+beta1*x
  10.32632+ 1.35384 * 50.5
# Number of paternal DNMs: 78.69524
  
# Step 2.5 — Compare distributions of maternal vs. paternal DNMs
# Plot both distributions on the same axes as semi-transparent histograms; .
par_joined <- dnm_counts %>%
    pivot_longer(cols = c(Maternal, Paternal),
                 names_to = "Parent",
                 values_to = "DNMs")

ggplot(data = par_joined, aes(x= DNMs , fill= Parent )) +
  geom_histogram(position = "identity", breaks= seq(0,100,2), alpha = 0.5) +
  labs(x = "Number of Individuals", y = "Count of DNMs")

# save as ex2_c.png
ggsave("~/qb25-answers/week5/ex2_c.png", width = 8, height = 4)

# Step 2.6 — Statistical test: maternal vs. paternal DNMs per proband
# We have paired observations per proband (maternal vs. paternal). The paired t-test assumes that the within-pair differences are approximately normally distributed.
# Apply a paired t-test in R
t.test(par_age_counts$Maternal, par_age_counts$Paternal, paired = TRUE)

# Note that the paired t-test is equivalent to using the difference between the maternal and paternal DNM counts per proband as the response variable and fitting a model with only an intercept term (indicated with 1 on the right side of the model formula). 
# Fit this model using lm() and compare to the results of the paired t-test. How would you interpret the coefficient estimate for the intercept term?
lm(data = par_age_counts, Maternal - Paternal ~ 1)  %>%
  summary()

# Exercise 3
# Step 3.1 — Pick a TidyTuesday dataset
install.packages("tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load(2025, week = 5)
simpsons_episodes <- tuesdata$simpsons_episodes

# Step 3.2 — Explore and visualize
# Generate figures and note any interesting patterns in README.md; save figures as ex4_<something>.png.
# Is there a difference between imdb score between air years
# Mutate year to character
simpsons_episodes <- simpsons_episodes %>%
  mutate(original_air_year = as.character(original_air_year))
# Boxplot comparing imdb rating between air years
ggplot(data = simpsons_episodes,
       aes(x= original_air_year, y = imdb_rating)) +
  geom_boxplot() +
  labs( 
    title = "Rating per Year",
    x = "Original Air Year",
    y = "IMDB Rating"
  )
ggsave("~/qb25-answers/week5/ex3_rating_year.png")

# Does year inlfuence the number of US viewers?
ggplot(data = simpsons_episodes,
       aes(x= original_air_year, y = us_viewers_in_millions)) +
  geom_boxplot() +
  labs( 
    title = "Number of Viewers per Year",
    x = "Original Air Year",
    y = "Number of U.S. Viewers (millions)"
  )
ggsave("~/qb25-answers/week5/ex3_viewers_year.png")

# Scatterplot of viewers vs rating
ggplot(data = simpsons_episodes, 
       aes(x= us_viewers_in_millions, y = imdb_rating)) +
  geom_point() +
  labs( 
    title = "Number of Viewers vs. IMDB Rating",
    x = "Number of U.S. Viewers (millions)",
    y = "IMDB Rating"
  )
ggsave("~/qb25-answers/week5/ex3_viewers_rating.png")

# Step 3.3 — Pose and test a linear-model hypothesis
# State a hypothesis, fit a linear model, evaluate fit, and report results in README.md.
# Is there a correlation between air year and number of viewers?
lm(data = simpsons_episodes, formula = us_viewers_in_millions ~ 1 + original_air_year ) %>%
  summary()



