#
# Compare Exponential distribution with Central Limit Theorem via Simulation
# Author: Sathish Duraisamy
# Date: 2015JAN24
#

#In this project you will investigate the exponential distribution in R and compare it with the Central Limit Theorem. The exponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations. You will investigate the distribution of averages of 40 exponentials. Note that you will need to do a thousand simulations.
#Illustrate via simulation and associated explanatory text the properties of the distribution of the mean of 40 exponentials.  You should
#  1. Show the sample mean and compare it to the theoretical mean of the distribution.
#  2. Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
#  3. Show that the distribution is approximately normal.
#
#In point 3, focus on the difference between the distribution of a large collection of random exponentials and the distribution of a large collection of averages of 40 exponentials.
#As a motivating example, compare the distribution of 1000 random uniforms



lambda <- 0.2
num_expo <- 40
num_simul <- 1000

set.seed(121212)
dat <- NULL
for (i in 1:num_simul) {
  row <- rexp(num_expo, lambda)
  dat <- rbind(dat, row);
}
dim(dat)

sample_means <- rowMeans(dat)

h <- hist(sample_means, breaks=200, probability = T, main = "Distribution of sample means")
lines(density(sample_means), col="skyblue", lwd=5)
# Draw a vertical line at the center of sample distribution
mean_of_sample_means <- mean(sample_means)
var_of_sample_means <- var(sample_means)
abline(v=mean_of_sample_means, col="skyblue", lwd=5)

# Draw another line as per theoretical values
theor_x <- seq(min(sample_means), max(sample_means), length=200)
theor_y <- dnorm(theor_x, mean=1/lambda, sd=(1/lambda/sqrt(num_expo)))
lines(theor_x, theor_y, pch=20, col="red", lwd=1)
# Draw a vertical line at the center of theoretical distribution
theoretical_mean <- 1 / lambda
theoretical_var <- (1/lambda/sqrt(num_expo))^2
abline(v=theoretical_mean, col="red", lwd=2)
legend("topright", legend = c("simulation", "theoretical"),
       lty = c(1,1), col = c("skyblue", "red"))
message(paste("mean-of-sample-means = ", round(mean_of_sample_means, 5),
              "   theoretical-men = ", round(theoretical_mean, 5), "\n", sep=""))

message(paste("variance-of-sample-means = ", round(var_of_sample_means, 5),
              "   theoretical-variance = ", round(theoretical_var, 5), "\n", sep=""))


#Given a population with a finite mean μ and a finite non-zero variance σ2,
#the sampling distribution of the mean approaches a normal distribution with
#a mean of μ and a variance of σ2/N as N, the sample size, increases.

