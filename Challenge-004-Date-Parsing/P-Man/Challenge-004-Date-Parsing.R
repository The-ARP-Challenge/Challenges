library(data.table)
library(stringr)

df <- read.csv('~/GitHub/ARP/Challenge-004-Date-Parsing/files/input.csv', as.is = TRUE)
# op <- read.csv('~/GitHub/ARP/Challenge-004-Date-Parsing/files/output.csv', as.is = TRUE)

# Extract the date
date <- str_match(df$Field_1,'(\\d+)-(\\w+)-(\\d+)|(\\w+) (\\d+),? (\\d+)')
date <- na.fill(date,'')

# Use data.tables to collate date parts
dt <- data.table(date)
dt[, `:=` (day     = as.numeric(paste0(V2,V6)),
           month   = paste0(V3,V5),
           years   = paste0(V4,V7),
           century = ifelse(nchar(year)==4,'', ifelse(as.integer(year)>15,'19','20')),
           year    = paste0(century,years ))]

# Alternative...
# dt[, c('V2','V3','V4') := .(paste0(V2,V6), paste0(V3,V5), paste0(V4,V7))]

# Format and add date column
df$DateTime_Out <- as.Date(paste(dt$year,dt$month,dt$day), '%Y %b %d')

# QED
