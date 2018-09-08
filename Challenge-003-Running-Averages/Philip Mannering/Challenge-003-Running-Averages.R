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

setwd('~/GitHub/ARP/Challenge-003-Running-Averages/Philip Mannering/')

library(stringr)
library(data.table)

df <- read.csv('../files/input.csv')
op <- read.csv('../files/output.csv')

# Create function to get the n-period rolling average of x
ma <- function(x,n){
  # Pad the vector to get nearest values for rows that do not exist!
  x <- c(rep(x[1],n-1),x)
  # Apply the rolling average
  ma <- rollapply(x, n, mean, align = 'right', partial = FALSE)
}


df_vals <- df[4:9]
for categor
df_3mo <- sapply(df[4:9],function(x) ma(x,3))
df_6mo <- sapply(df[4:9],function(x) ma(x,6))

names(df_3mo) <- str_c('r3mo_',str_replace(names(df[4:9]),'\\.','_'))








# df$date <- str_c(df$Year, df$Month, '01', sep='-')
# df$date <- as.Date(df$date,'%Y-%m-%d')
head(df)

u.ir <- df$u.IR
u.ir[1:10]
op$r3mo_u_IR[1:10]
rollapply(u.ir,3,mean)[1:10]
