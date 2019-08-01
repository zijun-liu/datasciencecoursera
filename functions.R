add2 <- function(x, y) {
        x + y
}

add2(3, 5)

# 2 variables
above <- function(x, n) {
        use <- x>n
        x[use]
}

x <- 1:10
above(x, 5)

# default a variable
above <- function(x, n = 5) {
        use <- x>n
        x[use]
}

above(x)

columnmean <- function(y, removeNA = TRUE) {
        nc <- ncol(y)
        means <- numeric(nc)
        for(i in 1:nc){
                means[i] <- mean(y[, i], na.rm = removeNA)
        }
        means
}
columnmean(airquality)
columnmean(airquality, FALSE)

# R functions can be matched positionally or by name.
args(lm) ## Argument List of a Function
# lm( y ~ x, mydata, 1:100, model = FALSE)

# defining a function
f <- function(a, b = 1, c = 2, d = NULL) {
        
}
## In addtion to not specifying a default value, you can also set an argument value to NULL.
f(a = 3)
## Lazy evaluation

f <- function(a, b) {
        a^2
}
f(2)

f <- function(a, b){
        print(a)
        print(b)
}
f(45)
# [1] 45
# Error in print(b) : argument "b" is missing, with no default

######## The "..." Argument ########
myplot <- function(x, y, type = "l", ...){
        plot(x, y, type = type, ...)
}
?paste
paste("a", "b", sep = ":")
paste("a", "b", se = ":") # ... can not be patially matched

lm <- function(x){
        x*x
}
lm(5)

search()
# [1] ".GlobalEnv"         "package:data.table" "package:forcats"    "package:stringr"    "package:dplyr"     
# [6] "package:purrr"      "package:readr"      "package:tidyr"      "package:tibble"     "package:ggplot2"   
# [11] "package:tidyverse"  "package:readxl"     "tools:rstudio"      "package:stats"      "package:graphics"  
# [16] "package:grDevices"  "package:utils"      "package:datasets"   "package:methods"    "Autoloads"         
# [21] "package:base"    
## the order of the search list matters!!


################################## Lexical Scoping ###########################################
make.power <- function(n){
        pow <- function(x){
                x^n
        }
        pow
}

cube <- make.power(3)
square <- make.power(2)

cube(5)
square(3)

# what's in a function's environment?
ls(environment(cube))
get("n", environment(cube))

# test
y <- 10
f <- function(x){
        y <- 2
        y^2 + g(x)
}

g <- function(x){
        x * y
}

f(3)

######################### Coding Standards for R ###############################
# 1. Always use text files/ text editor
# 2. indent your code
# 3. Limit the width of your code (80 columns?)
# 4. Limit the length of individual functions

########################## Dates and Times in R ###############################
x <- as.Date("1970-01-01")
x
unclass(x)
unclass(as.Date("1970-01-02"))

x <- Sys.time()
x
# [1] "2019-07-31 15:59:36 PDT"

x

# strptime function
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M") # look at help(strptime)
x
class(x)
help(strptime)

# operations on dates and times
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y
# Error in x - y : non-numeric argument to binary operator
# In addition: Warning message:
#         Incompatible methods ("-.Date", "-.POSIXt") for "-" 
x <- as.POSIXlt(x)
x-y
# Time difference of 356.1845 days

### quiz
x <- 1:10
if(x > 5) {
        x <- 0
}
x
#
f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}
z <- 10
f(3)

x <- 5
y <- if(x < 3) {
        NA
} else {
        10
}