# R Code for Chapter 1
# MATH 241, Fall 2026
# by: Jericho Lawson

#### Vectors and Data Frames ####

# To create a vector
x = c(1, 2, 4, 5)

# Types of vectors
c(1, 2, 3, 4, 5)      # double
c("a", "b", "c", "d") # character
c(T, F, F, T)         # logical

#### Basic Functions and Functionality ####

# Example of a function
mean(x)

# Tabulation of values
table(x) 

# For repeating values
rep(-1, 50) # value to repeat, number of repeats

# For sequence of numbers
1:50
seq(1, 50, 2)

# Basic calculations
3 + 4
c(2, 3) + c(6, 4)

#### sample function ####

# Used to sample from all possible outcomes
sample(x = c(rep("green", 7), rep("blue", 3), rep("red", 6), rep("purple", 4)), 
       size = 1, 
       replace = FALSE)

# x: Possible outcomes (from S)
# size: Number of trials
# replace: sample with replacement (TRUE) or without (FALSE)
# prob: probability of picking an outcome

# For later: can assign probabilities to getting an outcome

sample(x = c("green", "blue", "red", "purple"), 
       size = 1, 
       replace = FALSE, 
       prob = c(7/20, 3/20, 6/20, 4/20))

#### Number of Outcomes ####

# Let n = 10, k = 4

# Combination (sampling without replacement, no order)
choose(10, 4)

# Permutation (sampling without replacement, order)
factorial(10) / factorial(10 - 4)

# Sampling with replacement, no order
choose(10 + 4 - 1, 4)

# Sampling with replacement, order
10^4

#### Birthday Paradox ####

# The textbook goes through one way of getting solution, I'll go through my way.
# Because of the computational nature of the problem, a for-loop can be useful
# here for this single calculation. Here, we set an initial probability of 1
# and a vector of 50 probabilities with -1 as a placeholder. We want to track
# the probability of at least two people sharing the same birthday as we go
# from a class size of 1 to 50.

# We show the use of a for loop, which will allow us to solve the probability
# of no people sharing the same birthday, which is updated. We will also
# find the probability of at least two people sharing the same birthday at
# that value of k. We go from 365 to 316 -- equivalent to going from 1 to 50 for
# k. We set it up as such to make sure the indexing tracks as we make the
# calculations.

prob0 = 1
prob2 = rep(-1, 50)
for (i in 365:316){
  prob0 = prob0 * i / 365
  prob2[366 - i] = 1 - prob0
}

# We can now plot this probability as k increases
plot(1:50, prob2, type = "l", xlab = "k", ylab = "P(pair)")

# And we can look at these probabilities for specific values of k 
prob2[23]
prob2[seq(10, 50, 10)]

#### Aside: d, p, q, r prob Functions ####

# We will talk about this in later chapters, but to solve probability questions,
# we will use a family of R functions, with the following prefixes:

# - d___(): Used for exact probabilities for some input x with dist. ___
# - p___(): Used for cumulative probabilities for some input x with dist. ___
# - q___(): Used to find x for which the qth percentile occurs at with dist. ___
# - r___(): Used to randomize n number of observations with dist. ___

# There is one for the birthday paradox. To find the probability of at least
# two people sharing the same birthday in a classroom of k people, we can use:
pbirthday(23)

