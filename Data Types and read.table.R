# Numbers
1L # integer
Inf
1/Inf 
NaN # undefined value/ missing value
################################# Data Types: Vectors and Lists ##################################
# Creating vectors
(x <- c(5, 6))
(x <- vector("numeric", length = 5))

(y <- c(1.7, "a")) # coercion-> same class
(y <- c(TRUE, 2))
# Explicit coercion: as.* functions
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

x <- c("a", "b", "c")
as.numeric(x) #nonsensical coercion results in NAs

# Lists are a special type of vector, it can contain elements of different types
x <- list(1, "a", TRUE, 1+4i)
x # elements in lists have double brackets, elements in other vectors only have single brackets

##################################### Data Types: Matrices #######################################
# Matrices: vectors with a dimension attribute
m <- matrix(nrow = 2, ncol = 3)
m
dim(m)
attributes(m)

#matrices are constructed column-wise
m <- matrix(1:6, nrow = 2, ncol = 3)
m
# matrices can also be created directly from vectors by adding a dimension attribute
m <- 1:10
dim(m) <- c(2,5)
m
# matrices can be created by column-binding or row-binding
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)

##################################### Data Types: Factors #######################################
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x)
unclass(x)

# the order of the levels can be set using the levels argument to factor(). 
# This can be important in linear modelling because the 1st level is used as the baseline level.
x <- factor(c("yes", "yes", "no", "yes", "no"),
            levels = c("yes", "no"))

################################### Data Types: Missing Values ##################################
is.na()
is.nan()

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

################################### Data Types: Data Frame ######################################
x <- data.frame(foo = 1:4, bar = c(T, T, F, F))
x
nrow(x)
ncol(x)

################################### Data Types: Name Attribute ##################################
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf")
x
names(x)

x <- list(a=1, b=2, c=3)
x

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m
################################## Reading in large datasets with read.table #####################
initial <- read.table("name of file.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("name of file.txt", colClasses = classes)

