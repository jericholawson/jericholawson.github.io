# Hypothesis Testing with Randomization
# MATH 240

# Libraries used
library(tidyverse)

# Setting a seed for reproducibility
set.seed(240)

# Used to define treatment and control groups with their outcomes
groups <- c(rep("T", 34), rep("C", 16))
outcomes <- c(rep("Yawn", 10), rep("No Yawn", 24), rep("Yawn", 4), rep("No Yawn", 12))

# Generating yawn data (no need to change)
yawn_data <- data.frame(group = groups, 
                        outcome = outcomes)

# Rearrangement of data: shuffle order, arrange by treatment/control groups, add subject numbers, and rearrange columns
yawn_data <- yawn_data[sample(1:nrow(yawn_data), nrow(yawn_data), replace = F), ] |> 
  arrange(group) |> 
  mutate(id = 1:nrow(yawn_data)) |> 
  select(id, group, outcome)

# Getting sample proportions of those who yawned in the control and treatment groups
p_hats <- tapply(yawn_data$outcome == "Yawn", yawn_data$group, mean)
obs_diff <- p_hats[2] - p_hats[1]

# Defining a function to shuffle data so that we can use randomization to construct the
# null sampling distribution. 
shuffle <- function(data){
  # Input: A tidy dataset with 3 variables: id, group, and outcome.
  # Output: A number 'diff' which is the observed difference
  
  # Sort the assignment of participants in treatment/control groups
  new_data <- data |> mutate(newgroup = sample(group, nrow(data), replace=F))
  
  # Find the proportion of yawners in control and treatment groups
  new_p_hats <- tapply(new_data$outcome == "Yawn", new_data$newgroup, mean)
  
  # Find sample statistic
  new_diff <- new_p_hats[2] - new_p_hats[1]
  
  # Return result
  return(new_diff)
}

# Re-randomizing people to groups N times. This takes a few seconds to run.
N = 1000
results <- replicate(N, shuffle(yawn_data))

# Viewing Histogram
hist(results, main = "Null Sampling Distribution",
     xlab = "Observed Difference", ylab = "Frequency", breaks = 10)
abline(v = obs_diff, lwd = 1, col = "red")

# Getting p-value: proportion of times the difference was greater 0.04
pval <- mean(results > obs_diff)

