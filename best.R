library(tidyverse)

outcome <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", 
                    colClasses = "character")
head(outcome)
dim(outcome)

# 1. Plot the 30-day mortality rates for heart attack
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

# 2. Finding the best (lowest mortality rate) hospital in a state : 
# “heart attack”, “heart failure”, or “pneumonia”

best <- function(state, outcome) {
        ## Read outcome data
        df <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", 
                       colClasses = "character")
        df <- as.data.frame(cbind(df[, 2], 
                                  df[, 7],
                                  df[, 11], 
                                  df[, 17],
                                  df[, 23]
                                  )
                            )
        colnames(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        # df$state <- as.factor(df$state)
        ## Check that state and outcome are valid
        if (! state %in% df$state) {
                stop("invalid state") # "stop" stops execution of the current expression and executes an error action.
        }
        else if (! outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop("invalid outcome")
        }
        ## Return hospital name in that state with lowest 30-day death rate
        else {
                state_index <- which(df[, "state"] == state)
                state_data <- df[state_index, ]
                num_outcome <- as.numeric(state_data[, eval(outcome)]) # "eval": 
                min_val <- min(num_outcome, na.rm = TRUE)
                result  <- state_data[, "hospital"][which(num_outcome == min_val)]
                output  <- result[order(result)] # "order" returns a permutation which rearranges its first argument into ascending or descending order
        }
        return(output)
}

best("SC", "heart attack")

######################## failed attempts ###################################
# ?which
# 
# df <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", 
#                colClasses = "character")
# df <- as.data.frame(cbind(df[, 2], 
#                           df[, 7],
#                           df[, 11], 
#                           df[, 17],
#                           df[, 23]), stringsAsFactors = FALSE)
# colnames(df) <- c("hospital", "state_col", "heart attack mortality", "heart failure mortality", "pneumonia mortality")
# lapply(df, class)
# head(df)

# df[df == "Not Available"] <- NA
# # all char
# df["heart attack mortality"] <- as.numeric(as.character(df["heart attack mortality"]))
# df["heart failure mortality"] <- as.numeric(as.character(df["heart failure mortality"]))
# df["pneumonia mortality"] <- as.numeric(as.character(df["pneumonia mortality"]))
# lapply(df, class)
# head(df)
# test
# as.numeric(as.character(df["heart attack mortality"]))
# 
# group_by(df, state_col) %>% 
#         summarize(min(`heart attack mortality`, na.rm = TRUE))
