## Produce climate data overview, write TAF data tables

## Before: climate.rds (data)
## After:  climate_overview.csv, climate_variables.dat (data)

library(TAF)

mkdir("data")

climate <- readRDS("data/climate.rds")

# Climate variables
var.list <- sapply(climate, names)
vars <- sort(unique(unlist(var.list)))

# Calculate climate data overview
climate.overview <- sapply(var.list, function(x) vars %in% x)
rownames(climate.overview) <- vars
climate.overview <- xtab2taf(t(climate.overview), "City")

# Identify variables that are defined for all cities
climate.variables <- sapply(climate.overview[-1], all)
climate.variables <- names(climate.variables)[climate.variables]

# Write table
write.taf(climate.overview, dir="data")
write(climate.variables, "data/climate_variables.dat")
