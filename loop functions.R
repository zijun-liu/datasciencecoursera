########################### Loop Functions ####################################
## lapply
## always returns a list, regardless of the class of input
x <- list(a = 1:5, b= rnorm(10))
x
# list in R is different from list in Python
# https://data-flair.training/blogs/r-list-tutorial/
lapply(x, mean)
sapply(x, mean)

x <- 1:4
lapply(x, runif) # runif generates uniform random variables
lapply(x, runif, min = 0, max = 10)

# lapply and friends make heavy use of anonymous functions
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x

# an anonymous function for extracting the first column of each matrix
lapply(x, function(elt) elt[, 1])

## apply
## is used to evaluate a function (often an anonymous one) over the margins of
## an array.

x <- matrix(rnorm(200), 20, 10)
x
apply(x, 2, mean)
apply(x, 1, sum)

# rowSums = apply(x, 1, sum)
# rowMeans = apply(x, 1, mean)
# colSums = apply(x, 2, sum)
# colMeans = apply(x, 2, mean)
# The shortcut functions are MUCH FASTER.

# quantiles of the rows of a matrix
x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))

# average matrix in an array
a <- array(rnorm(2*2*10), c(2, 2, 20))
a
# Arrays are the R data objects which can store data in more than two dimensions. 
# For example − If we create an array of dimension (2, 3, 4) 
# then it creates 4 rectangular matrices each with 2 rows and 3 columns. 
apply(a, c(1, 2), mean)
rowMeans(a, dims = 2)


## mapply
## is a multivariate apply of sorts which applies a function in parallel over 
## a set of arguments
?mapply
# example: the following is tedious to type:
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
# instead we can do
mapply(rep, 1:4, 4:1)

# example: generate random noise
noise <- function(n, mean, sd){
        rnorm(n, mean, sd)
}
noise(5, 1, 2)
mapply(noise, 1:5, 1:5, 2) # set sd as always 2
#which is the same as
list(noise(1, 1, 2), noise(2, 2, 2), 
     noise(3, 3, 2), noise(4, 4, 2), 
     noise(5, 5, 2))

## tapply
## is used to apply a function over subsets of a vector.
?tapply
# example
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) # Generate Factor Levels
f
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)


## split
## takes a vector or other objects and splits it into groups determined by a 
## factor or list of factors.
# example
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) # Generate Factor Levels
split(x, f)
# a common idiom is split followed by lapply
lapply(split(x, f), mean) # which can be achieved by tapply

# Splitting a Data Frame
library(datasets)
head(airquality)
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))

# splitting on more than 1 level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
f2
interaction(f1, f2)
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = TRUE))
