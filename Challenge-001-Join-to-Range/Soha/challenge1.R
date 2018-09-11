library(tidyr)
library(data.table)

# Load the data -----------------------------------------------------------

customerdata <- read.csv("C:/Users/Soha Elghany/Documents/challenges for R/customerdata1.csv")
customerdata

postalcode <- read.csv("C:/Users/Soha Elghany/Documents/challenges for R/postaldata1.csv")
postalcode

# Split the column --------------------------------------------------------

# Create a LIST, by going to the data, splitting the 2000-2019 column, into two parts.
# Every item in the list will have 2 values.
# We will loop throuh them later.
splits = strsplit(as.character(postalcode$Range), "-")

# We can use sapply to do loops.
# We are saying: for every item in splits, do something.
# That something is to get the first item.
postalcode$first_part = sapply(splits, function(x){
  x[1]
})

# Same as above but get item 2.
postalcode$second_part = sapply(splits, function(x){
  x[2]
})

# Or, we can do this:
postalcode_splits = separate(postalcode, col="Range", into=c("1", "2"), sep="-")

# Generate new rows. ------------------------------------------------------
# lapply makes a list. sapply makes a vector.
list_of_tables = lapply(1:nrow(postalcode_splits), function(row){
  # Go to the main data, and get me a row.
  this_row = postalcode_splits[row,]
  # Create a list of years for the new rows. i.e. 1 and 10 becomes 1,2,3,4,5,6,7,8,9,10
  these_years = as.numeric(this_row$`1`):as.numeric(this_row$`2`)
  # Create a new table, using the new years as the RowCount column.
  # It will also add the rest of the data from before.
  this_table = data.frame(
    RowCount = these_years,
    this_row
  )
  # Spit out the new table. We will create a list of tables that we will join later.
  return(this_table)
})

# Join the tables into one table.
postalcode_new_rows = rbindlist(list_of_tables)

# Do the join! ------------------------------------------------------------
joined_data = merge(
  # x = left, y = right
  x = customerdata,
  y = postalcode_new_rows,
  # which columns do we use?
  by.x = "Postal.Area",
  by.y = "RowCount"
)

# Do the counts -----------------------------------------------------------
df = data.frame(
  table(joined_data$Region, joined_data$Sales.Rep, joined_data$Responder)
)

df[df$Freq > 0,]


