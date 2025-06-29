## Run analysis of daylight duration, write model results

## Before: coordinates.csv (data)
## After:  daylight.csv (model)

library(TAF)
library(solrad)

mkdir("model")

# Read data
coordinates <- read.taf("data/coordinates.csv")

# Calculate shortest day
daylight <- coordinates
daylight$Shortest.day <- suppressWarnings(
  sapply(daylight$North, function(x) min(DayLength(1:365, x))))
daylight$Shortest.day[is.nan(daylight$Shortest.day)] <- 0

# Write TAF tables
write.taf(daylight, dir="model")
