# Step 2.2 — OLS: maternal age vs. maternal DNMs
1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?
- slope: 0.37757
- This slope means that as the mothers age increases, for each year, the DNM rate increases by about 38%.
- My plot does have a slight upward trend, so it does seem to match generally. But it is still pretty scattered.
2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.
- The p-value is <2e-1, which means the relationship is extremely significant. 
- This means that mother age is a strong indicator of number of mutations.

# Step 2.4 — Predict for a 50.5-year-old father
Use the paternal regression model to predict the expected number of paternal DNMs for a father of age 50.5. You are welcome to do this manually or using a built-in function, but show your work in README.md.
- y=beta0+beta1*x \
  ``10.32632+ 1.35384 * 50.5`` \
- Number of paternal DNMs: 78.69524

# Step 2.6 — Statistical test: maternal vs. paternal DNMs per proband
1. What is the “size” of this relationship (i.e., the average difference in counts of maternal and paternal DNMs)? \
Interpret the difference in plain language. Does it match your plot? 
- The size is -39.23485. This means that on average there are about 39 more DNMs in fathers than mothers.
- This does not match my plot exactly. The plot makes it seem like women have more DNMs since the number of mothers is not as high as the number of fathers. Since there are more fathers, it looks more spaced out and it seems they have less DNMs

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.
- This is highly significant because a p-value of < 2.2e-16 means that this is the chance of seeing this outcome if the null hypothesis were true and since this number of very low, it means it would almost never happen, affirming the alternative hypothesis.


Note that the paired t-test is equivalent to using the difference between the maternal and paternal DNM counts per proband as the response variable and fitting a model with only an intercept term (indicated with 1 on the right side of the model formula). \
Fit this model using lm() and compare to the results of the paired t-test. \
How would you interpret the coefficient estimate for the intercept term?
- The intercept is the same as the mean difference in the t-test.
- Again, this is the average difference in DNMs between maternal and paternal and fathers have about 39 more DNMs on average than mothers.

# Step 3.1 — Pick a TidyTuesday dataset
I chose the "Donuts, Data, and D'oh - A Deep Dive into The Simpsons" Dataset

Interpretations from figures:
1. Boxplot comparing imdb rating between air years
- Across the years, the average rating seems to stay just under 7 so it does not seem like year influences rating.
2. Boxplot comparing number of US viewers between years
- It seems that the average number of viewers decreases across the years
3. Scatterplot of viewers vs rating
- The scatterplot does not appear to have any upward or downward trend, it stays generally flat, so it does not appear that the number of views has an impact on the IMDB rating.

# Step 3.3 — Pose and test a linear-model hypothesis
Does number of viewers significanltly decrease each year after 2010? \
- Hypothesis: Based on what I saw in the boxplot, I think each year other than 2011 will have significantly lower viewers than the number of viewers in 2010. \
- Based on the p-value and using 2010 as the base value, year 2011 is the only year where number if viewers were not significantly different from what they were in 2010. \
original_air_year2011  -0.4106     0.5422  -0.757 0.450108    \
original_air_year2012  -1.3431     0.5489  -2.447 0.015632 *  \
original_air_year2013  -1.8202     0.5422  -3.357 0.001012 ** \
original_air_year2014  -2.0288     0.5360  -3.785 0.000227 *** \
original_air_year2015  -2.8606     0.5422  -5.276 4.86e-07 *** \
original_air_year2016  -3.7212     0.6177  -6.024 1.41e-08 *** \


