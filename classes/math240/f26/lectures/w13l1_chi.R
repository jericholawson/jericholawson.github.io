# MATH 240
# Chi-Squared Calculation
# Fall 2026

# Define expected table of values
o <- matrix(c(45, 15, 36, 24, 24, 36), nrow = 3, ncol = 2, byrow = T) 

# Determine observed values. Start with empty matrix
e <- matrix(0, nrow = 3, ncol = 2, byrow = T) 

# Use for-loop to find e for all cells
for (i in 1:nrow(e)){
  for (j in 1:ncol(e)){
    e[i, j] = rowSums(o)[i] * colSums(o)[j] / sum(o)
  }
}

# Find chi-square statistic
x2 <- sum((o - e)^2 / e)

# Find p-value
pchisq(x2, (nrow(e) - 1) * (nrow(o) - 1), lower.tail = F)
