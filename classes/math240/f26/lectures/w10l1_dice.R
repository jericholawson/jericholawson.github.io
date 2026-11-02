# Confidence Intervals with Bootstrapping
# MATH 240
# Fall 2026

ITS = 100
B = 5000
n = 50
P0 = 0.8
ALPHA = 0.05

# Libaries to load in
library(infer)
library(ggplot2)
library(infer)

# Set seed for reproducibility
set.seed(3222023)

# Used to collect results (we will row-bind for each sample taken)
CI_result <- c()
for (i in 1:ITS){
  # Generate 50 die rolls assuming a loaded die
  die_sample <- data.frame(result=sample(c("Six", "Other"), size=n, prob=c(P0, 1 - P0), replace=TRUE))
  
  # Find the bootstrap distribution for p.hat
  boot_sample <- die_sample |> specify(response = result, success="Six") |>
    generate(reps = B, type="bootstrap") |>
    calculate(stat = "prop")
  
  # Calculate the 95% CI
  boot_ci <- boot_sample |> get_ci(level=1 - ALPHA)
  
  # Record the results
  lower <- as.numeric(boot_ci[1])
  upper <- as.numeric(boot_ci[2])
  cover <- (P0 >= lower) & (P0 <= upper)
  result <- data.frame(trial=i, lower=lower, upper=upper, color=cover)
  CI_result <- rbind(CI_result, result)
}

# Visualize bootstrap distribution
boot_sample |> visualize(bins=12)

# Visualize the bootstrap distribution for p.hat
boot_sample |> visualize(bins=12) + shade_ci(boot_ci)

# Create plot of all 100 95% CIs and see that 95 of them contain the true 
# population parameter while 5 of them do not
ci100 <- ggplot(CI_result, aes(y = trial)) +
  geom_segment(aes(x=lower, y=trial, xend=upper, yend=trial, color= color),
               show.legend=FALSE) +
  annotate("segment", x=P0, xend=P0,
           y=0, yend=101, color="black") +
  labs(x=expression(hat(p)), y = "Iteration") +
  theme_minimal()

# Show plot
ci100