# Challenge 002 - Preparing Delimited Data
# Author: Philip Mannering
# Date: 2018-09-07

# All the glorious regex functions!
library(stringr)

setwd('~/Github/ARP/Challenge-002-Preparing-Delimited-Data/Philip Mannering/')

# Read in input
df <- read.csv('../files/input.csv')

# Split field by a comma
splitted <- str_split_fixed(df$Field_1,',',3)

# Remove single and double quotes
splitted <- apply(splitted, 2, function(x) str_remove_all(x,'[\'"]'))

# Change matrix to dataframe
splitted <- as.data.frame(splitted)
names(splitted) = c('Poem','Poem_ID','Poem_Read_Date')

# Change datatype
ans <- transform(splitted,  Poem = as.character(Poem),
                            Poem_ID = as.numeric(as.character(Poem_ID)),
                            Poem_Read_Date = as.Date(Poem_Read_Date, '%d-%b-%y'))


# Check the output
op <- read.csv('../files/output.csv', as.is=T,
               colClasses = c('character','numeric','Date'))
identical(ans,op)

