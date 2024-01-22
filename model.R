## Run analysis, write model results

## Before: coordinates.csv, uv.rds (data)
## After:  uv_index.csv (model)

library(TAF)
source("utilities.R")  # lookup_uv

mkdir("model")

# Read data
coordinates <- read.taf("data/coordinates.csv")
uv <- readRDS("data/uv.rds")

# Look up UV values for city coordinates
uv.index <- sapply(coordinates$City, lookup_uv)
uv.index <- xtab2taf(uv.index, "Month")

# Write TAF table
write.taf(uv.index, dir="model")
