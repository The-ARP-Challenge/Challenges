#GitHub Test
setwd("~/ARP/Week 1")

#Read in files
Customers <- read.csv('Input Files/Customers.csv')
SalesReps <- read.csv('Input Files/Sales Reps.csv')

#Load Packages
library(dplyr)
library(tidyr)

#Split Postal Area range to columns
SalesReps2 <- separate(SalesReps,Range,c("A","B"),sep="-")
SalesReps2[1:2] = data.matrix(SalesReps2[1:2]) #Convert Postal Area cols to numeric

#Create empty dataframe to store loop results
df <- data.frame(as.numeric(),as.character())


#Loop over each row, generating a continuous sequence between start and end Postal Areas
for(i in 1:nrow(SalesReps2)) {
  row <- SalesReps2[i,] #Filter to row
  Seq <- row$A:row$B #Generate continuous sequence
  df <- rbind(df,data.frame(Postal.Area = Seq, Sales.Rep = row$Sales.Rep)) #Union to output table
}

#Join the Sales Rep coverage with the Customer table
RepsCust <- left_join(Customers,df,by="Postal.Area") %>%
  group_by(Sales.Rep,Responder) %>% ##Group by relevant dimensions
  summarise(Count=n()) #Count customers within each grouping
