## Run analysis of UV index, write model results

## Before: coordinates.csv, uv.rds (data)
## After:  uv_cities.csv, uv_world_avg.csv, uv_world_max.csv (model)

library(TAF)
source("utilities.R")  # lookup_uv

mkdir("model")

# Read data
coordinates <- read.taf("data/coordinates.csv")
uv <- readRDS("data/uv.rds")

# Look up UV values for city coordinates
uv.cities <- sapply(coordinates$City, lookup_uv)
uv.cities <- xtab2taf(uv.cities, "Month")

# Calculate average and maximum UV index
msg("  * calculating average UV by 0.5 deg squares")
uv.world.avg <- aggregate(Index~North+East, uv, mean)
msg("  * calculating maximum UV by 0.5 deg squares")
uv.world.max <- aggregate(Index~North+East, uv, max)

# Write TAF tables
write.taf(uv.cities, dir="model")
write.taf(uv.world.avg, dir="model")
write.taf(uv.world.max, dir="model")
