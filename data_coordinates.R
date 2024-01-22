## Preprocess geographic coordinate data, write TAF data tables

## Before: coordinates.csv (boot/data)
## After:  coordinates.csv (data)

library(TAF)
library(gmt)  # deg2num

mkdir("data")

# Read geographic coordinates
coordinates <- read.taf("boot/data/coordinates.csv")

# Convert coordinates from degree to numeric format
coordinates$North <- round(deg2num(coordinates$Lat), 4)
coordinates$East <- round(deg2num(coordinates$Lon), 4)

# Write table
write.taf(coordinates, dir="data")
