library(tidyverse)
# Part 1
# Write a function named 'pollutantmean' that calculates the mean of a pollutant 
# (sulfate or nitrate) across a specified list of monitors. The function 
# 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' 
# particulate matter data from the directory specified in the 'directory' argument
# and returns the mean of the pollutant across all of the monitors, ignoring any
# missing values coded as NA.

pollutantmean <- function(directory, pollutant, id = 1:332) {
        fileList <- list.files(path = directory, pattern = ".csv",
                               full.names = TRUE)
        values <- numeric() # create an object of type "numeric"
        
        for (i in id) {
                df = read_csv(fileList[i])
                values <- c(values, df[[pollutant]])
        }
        mean(values, na.rm = TRUE)
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)


# Part 2
# Write a function that reads a directory full of files and reports the number 
# of completely observed cases in each data file. The function should return a 
# data frame where the first column is the name of the file and the second column
# is the number of complete cases. 
test <- read.csv("/Users/zliu/Desktop/coursera jhu/R programming/week2/specdata/001.csv")
sum(complete.cases(test))
complete <- function(directory, id = 1:332) {
        fileList <- list.files(path = directory, pattern = ".csv",
                               full.names = TRUE)
        id_list <- numeric()
        complete_cases <- numeric()
        
        for (i in id) {
                df = read_csv(fileList[i])
                id_list <- c(id_list, i)
                complete_cases <- c(complete_cases, sum(complete.cases(df)))
        }
        data.frame(cbind(id_list, complete_cases))
}

complete("specdata", 1:10)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
class(complete("specdata", 3))


# Part 3
# Write a function that takes a directory of data files and a threshold for 
# complete cases and calculates the correlation between sulfate and nitrate 
# for monitor locations where the number of completely observed cases 
# (on all variables) is greater than the threshold. The function should return
# a vector of correlations for the monitors that meet the threshold requirement. 
# If no monitors meet the threshold requirement, then the function should return
# a numeric vector of length 0. A prototype of this function follows
corr <- function(directory, threshold = 0) {
        fileList <- list.files(path = directory, pattern = ".csv",
                               full.names = TRUE)
        r <- numeric()
        for (i in fileList){
                df <- read.csv(i)
                num_complete <- sum(complete.cases(df))
                if (num_complete > threshold) {
                        r <- c(r, cor(df[['sulfate']], df[["nitrate"]], use = "complete.obs"))
                }
        }
        r
}

cr <- corr("specdata", 400)
head(cr)
summary(cr)


# quiz
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc)

cc <- complete("specdata", 54)
print(cc$complete_cases)

RNGversion("3.5.1")  
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "complete_cases"])

cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))