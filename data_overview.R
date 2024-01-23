## Produce climate data overview, write TAF data tables

## Before: climate.rds (data)
## After:  climate.csv (data)

library(TAF)

mkdir("data")

climate <- readRDS("data/climate.rds")

# Climate variables
var.list <- sapply(climate, names)
vars <- sort(unique(unlist(var.list)))

# Calculate climate data overview
overview <- sapply(var.list, function(x) vars %in% x)
rownames(overview) <- vars
overview <- xtab2taf(t(overview), "City")

# Write table
write.taf(overview, dir="data")
