############################# str function ####################################
str(str)
str(lm)
str(ls)

x <- rnorm(100, 2, 4)
summary(x)
str(x)

f <- gl(40, 10) # gl: generate (factor) levels
str(f)

library(datasets)
head(airquality)
str(airquality)
summary(airquality)

m <- matrix(rnorm(100), 10, 10)
str(m)
m[, 1]

s <- split(airquality, airquality$Month)
str(s)

############################ simulation ########################################
# generating random numbers
# functions of probability distributions in R
# rnorm
# dnorm
# pnorm
# rpois
# 
# probability distribution functions usually have 4 functions associated with
# them, The functions are prefixed with a
# d for density
# r for ransom number generation
# p for cummulative distribution
# q for quantile function

# Always set the random number seed when conducting a simulation!
set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1)
rnorm(5)

# Generating Random Numbers From a Linear Model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)
# what if x is binary?
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)
# simulate a Poisson model
# Y ~ Poisson(mu)
# logmu = betaknot + beta1x and betaknot = 0.5 and beta1 = 0.3
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 +0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)

### simulation: random sampling #############
# The sample function draws randomly from a specified set of (scalar) objects 
# allowing you to sample from arbitrary distributions.
set.seed(1)
sample(1:10, 4)
sample(letters, 5)
sample(1:10) # permutation
sample(1:10, replace = TRUE) ## sample w/ replacement

