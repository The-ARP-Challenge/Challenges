# Challenge-003 - Running Averages
# Author: Philip mannering
# Date: 2018-09-08
# 
# Running Averages
# 
# The goal is to create a 3 and 6 month running averages for the values contained in columns: 
#   u.CAGI, d.CAGI, u.IR, d.IR, u.NonIR, d.NonIR by HP Category.
# 
# For example:
#   
#   Month:      Value:      Running 3 mo. Average:
#   1           218         218
#   2           200         212
#   3           272         233
# 
# Hint: For Values that do not exist, set values to closest valid row.

setwd('~/GitHub/ARP/Challenge-003-Running-Averages/P-Man/')

library(stringr)
library(data.table)
library(zoo)

df <- read.csv('../files/input.csv')
op <- read.csv('../files/output.csv')

# Convert data.frame to data.table
dt <- as.data.table(df)

# Function to get n-month rolling average
rmo <- function(x,n){
  x[is.na(x)] <- 0
  rollapply(x, n, mean, fill='extend', partial = TRUE, align = 'right')
}

# Rolling colnames
rnames <- names(dt)[4:9]

# Add record ID
dt[, RecordID := 1:.N]

# Add 3-month rolling averages
dt[ , paste0('r3mo_',rnames) := lapply(.SD, function(x) rmo(x,3)),
      .SDcols=rnames, by= HP.Category]

# Add 6-month rolling averages
dt[ , paste0('r6mo_',rnames) := lapply(.SD, function(x) rmo(x,6)),
      .SDcols=rnames, by = HP.Category]

# QED
