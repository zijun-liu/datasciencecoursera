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

complete <- function(directory, id = 1:332) {
        fileList <- list.files(path = directory, pattern = ".csv",
                               full.names = TRUE)
        id <- numeric()
        
        for (i in id) {
                id <- c(id, i)
                nobs <- c()
        }
}
sum(complete.cases(test))
