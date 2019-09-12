library(tidyverse)

rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        df <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", 
                       colClasses = "character")
        df <- as.data.frame(cbind(df[, 2], df[, 7], df[, 11], df[, 17], df[, 23]),
                            stringsAsFactors = FALSE)
        
        colnames(df) <- c("hospital", "state_col", "heart attack", "heart failure", "pneumonia")
        
        ## Check that state and outcome are valid
        if (! state %in% df$state_col) {
                stop("invalid state") # "stop" stops execution of the current expression and executes an error action.
        }
        else if (! outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop("invalid outcome")
        }
        ## Return hospital name in that state with the given rank
        else{
                # subset df
                df <- subset(df, state_col == state)
                ordered <- df[order(df[outcome], df$hospital, na.last = NA), ]
                ordered <- ordered[!is.na(ordered[outcome]), ]
                ordered <- ordered %>% 
                        filter(ordered[outcome] != "Not Available") #########
                if (num == "best"){
                        num = 1
                }
                else if (num == "worst"){
                        num = nrow(ordered)
                }
                output <- ordered[num, "hospital"]
                }
        return(output)
        #return(ordered)
}


rankhospital("TX", "heart failure", 4)
rankhospital("MN", "heart attack", 190)
rankhospital("MD", "heart attack", "worst")
