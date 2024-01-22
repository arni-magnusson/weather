## Run analysis of temperature data, write model results

## Before: climate.rds (data)
## After:  temp.csv (model)

library(TAF)

mkdir("data")

# Read climate tables
climate <- readRDS("data/climate.rds")

# Calculate key temperature values
temp <- data.frame(City=names(climate),
                   Summer.day=sapply(climate, \(x) max(x$Daily.max)),
                   Summer.night=sapply(climate, \(x) max(x$Daily.min)),
                   Winter.day=sapply(climate, \(x) min(x$Daily.max)),
                   Winter.night=sapply(climate, \(x) min(x$Daily.min)),
                   row.names=NULL)

# Write TAF table
write.taf(temp, dir="model")
