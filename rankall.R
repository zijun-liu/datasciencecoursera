library(tidyverse)

setwd("~/Desktop/cousera R programming assignment3")

# # read in dataset and keep only useful columns
# df <- read_csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")
# df <- df[, c(2, 7, 11, 17, 23)]
# lapply(df, class)
# 
# # convert data types: character to factor and numeric
# colnames(df) <- c("hospital", "state_col", "heart attack", "heart failure", "pneumonia")
# df$state_col <- factor(df$state_col)
# df[, c("heart attack", "heart failure", "pneumonia")] <- 
#         sapply(df[, c("heart attack", "heart failure", "pneumonia")], as.numeric)
# lapply(df, class)


# rankall <- function(outcome, num = "best") {
#         outcome <- sym(outcome)
#         
#         ## Read outcome data and clean
#         df <- read_csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")
#         df <- df[, c(2, 7, 11, 17, 23)]
#         colnames(df) <- c("hospital", "state_col", "heart attack", "heart failure", "pneumonia")
#         df$state_col <- factor(df$state_col)
#         df[, c("heart attack", "heart failure", "pneumonia")] <- 
#                 sapply(df[, c("heart attack", "heart failure", "pneumonia")], as.numeric)
#         
#         # ## Check that outcome is valid
#         if (! as.character(outcome) %in% c("heart attack", "heart failure", "pneumonia")) {
#                 stop("invalid outcome")
#         }
#         
#         ## For each state, find the hospital of the given rank
#         output <- df %>% 
#                 group_by(state_col) %>% 
#                 arrange(!!outcome, hospital) %>%  # double bang
#                 filter(row_number() == num)
#         ## Return a data frame with the hospital names and the
#         ## (abbreviated) state name
#         output <- output[, c("hospital", "state_col")] %>% 
#                 arrange(state_col)
#         return(output)
# }


rankall <- function(outcome, num = "best") {
        outcome <- sym(outcome)
        
        ## Read outcome data and clean
        df <- read_csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")
        df <- df[, c(2, 7, 11, 17, 23)]
        colnames(df) <- c("hospital", "state_col", "heart attack", "heart failure", "pneumonia")
        df$state_col <- factor(df$state_col)
        df[, c("heart attack", "heart failure", "pneumonia")] <- 
                sapply(df[, c("heart attack", "heart failure", "pneumonia")], as.numeric)
        
        # ## Check that outcome is valid
        if (! as.character(outcome) %in% c("heart attack", "heart failure", "pneumonia")) {
                stop("invalid outcome")
        }
        
        ## For each state, find the hospital of the given rank
        if (num == "best") {
                num = 1
        } else if (num == "worst") {
                num = length(unique(df$state_col)) # the last number where not null
        }
        output <- df %>%
                distinct(state_col) %>% 
                arrange(state_col) %>%
                left_join(
                        df %>% 
                                group_by(state_col) %>% 
                                arrange(!!outcome, `hospital`) %>% 
                                filter(row_number() == num),
                        by = "state_col"
                )
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        output <- output[, c("hospital", "state_col")] %>% 
                arrange(state_col)
        return(output)
}


head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)
# output <-
        


df %>%
        distinct(state_col) %>% 
        arrange(state_col) %>%
        left_join(
                df %>% 
                        group_by(state_col) %>% 
                        arrange(`heart attack`, `hospital`) %>% 
                        filter(row_number() == 20),
                by = "state_col"
        )


df[, c("hospital", "state_col")]
outcome <- "heart attack"
outcome_cleaned <- chartr(old = '"', new = '`', outcome)
df$state_col
test <- df %>% 
        filter(state_col == "WY") %>% 
        arrange(`pneumonia`)




# quiz
r <- rankall("heart attack", 4)
r
as.character(subset(r, state == "HI")$hospital)


r <- rankall("pneumonia", "worst")
r
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
r
as.character(subset(r, state == "NV")$hospital)
