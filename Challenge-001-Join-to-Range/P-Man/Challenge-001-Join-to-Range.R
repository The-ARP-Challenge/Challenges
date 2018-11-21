# Challenge 1 - Joining Postcodes
# Author: Philip Mannering
# Date: 27/08/2018

# A company in Australia has source data which is made up of a series of postal
# codes (eg. 2000, 2001, 2002 etc.) amongst some other data fields. They have a
# separate reference table which contains postcode ranges (eg. 2000 to 2002)
# which they would like to use to match/filter their main data.

# Each Customer Record needs to be joined to the Lookup table based on a Postal
# Area Ranged region. Then finally summarize the customer data by Region, Sales
# Rep, and Responder, then a count of customers.

# Time it
#ptm <- proc.time()

# Load libraries
library(data.table)

# Set the working directory
setwd('~/GitHub/ARP/Challenge-001-Join-to-Range/P-Man/')

# Load the data
range = read.csv(file = '../files/range.csv')
customer = read.csv(file = '../files/customer.csv')

# Extract the postcode areas from the Range and convert to numbers
r1 <- as.integer(substr(range$Range, 1, 4))
r2 <- as.integer(substr(range$Range, 6, 9))

# Create an empty list
range.list = list()

# Each list entry contains the whole range of postcode values
for (i in 1:nrow(range)){
  range.list[[i]] <- cbind(RowCount = r1[i]:r2[i], range[i,], 
                         row.names = NULL)
  }

# Concatenate the list of data frames into one single data frame
# 1. Using rbindlist from the data.table backage.
# 2. Or using rbind.fill from the plyr package.
range <- rbindlist(range.list)

# Join the data frames  
# NB: put the data.table first for the merged object to be a data.table.
dt <- merge(range, customer,
                by.x = 'RowCount',
                by.y = 'Postal.Area')

# Check number of unique values across whole data table
#sapply(dt, function(x) length(unique(x)))

# Summarize
ans <- dt[,.(Count= length(unique(Customer.ID))), 
          by = .(Region, Sales.Rep, Responder)]

print(ans)

# Time it
#print(proc.time()-ptm)
