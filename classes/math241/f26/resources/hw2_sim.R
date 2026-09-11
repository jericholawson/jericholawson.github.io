## Your name here
## MATH 240
## Fall 2026
## HW2: R Code, Monte Carlo Simulations

#### Example 1: Two Pairs ####

# Setup of model
cards = rep(1:13, 4) # Cards arrange as 1-13, repeated 4 times over
# Note that the goal is to get two pairs and one single card

# Replicates
N = 1000
successes = rep(-1, N) # Stores a success for a given draw

# For loop to repeat experiment
for (i in 1:N){
  # Sampling mechanism, we choose 5 cards randomly without replacement
  res = sample(cards, 5, replace = F) 
  
  # We get a table of counts, we want to find if there are two counts that are equal to 2
  # since we want two pairs. If so, we have a success
  successes[i] = sum(table(res) == 2) == 2
}

# Gathers probability of getting two pairs (e.g. take proportion of all successes that are TRUE)
mean(successes == TRUE)

#### Problem ####

# Number of replicates
N = 100

# Threshold for achieving a successful set of plays
success_threshold = 10

# Possible outcomes
#### outcomes <- c(___, ____, ___)

# Vector to store final yardage after four plays for a single replicate
yards_gained <- rep(-1, N)

# For loop to go through all possible replicates
for (i in 1:N){
  # In a replicate: sample four possible plays, with equal probability of an outcome occurring
  ###### res <- sample(________, __, replace = ____)

  # Store sum of yardage in an element in the results vector
  ###### yards_gained[i] <- _________(res)
}

# Determine number of times an element is equal to or greater than 10, divide by number of replicates
# This is done as we increase N.
probs = cumsum(yards_gained >= success_threshold) / 1:N
probs[N]

# Plot of the replicates.
plot(1:N, probs, type = "l", ylab = "P(success)", xlab = "Number of Replicates")