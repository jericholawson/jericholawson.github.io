# MATH 240
# Fall 2026
# Bootstrapping for Confidence Intervals

# 1. Set seed for replicating random results
set.seed(13)

# 2. Label subjects as those who will vote and those that will not
votes = c(rep("vote", 668), rep("not", 2024 - 668))
votes = sample(votes, replace = F) # used to randomize the sample

# 3. Set number of bootstrap samples; setup
N = 10000
prop = rep(-1, N)

# 4. For one bootstrap sample: sample with replacement, get proportion
for (i in 1:N){
  boot_sample <- sample(votes, replace = T)
  prop[i] = mean(boot_sample == "vote")
}

# 5. Show histogram; find 2.5th and 97.5th percentiles for CI
hist(prop)
quantile(prop, c(0.025, 0.975))

