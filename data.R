## Preprocess data, write TAF data tables

## Before: coordinates.csv, copenhagen.csv, fairbanks.csv, juneau.csv,
##         new_bedford.csv, noumea.csv, reykjavik.csv, rome.csv, seattle.csv,
##         victoria.csv (boot/data)
## After:  cities.rds, coordinates.csv, temp.csv (data)

library(TAF)
library(gmt)
source("utilities.R")

mkdir("data")

# Read climate tables from Wikipedia
copenhagen <- import_climate_wiki("copenhagen")
fairbanks <- import_climate_wiki("fairbanks")
juneau <- import_climate_wiki("juneau")
new.bedford <- import_climate_wiki("new_bedford")
noumea <- import_climate_wiki("noumea")
reykjavik <- import_climate_wiki("reykjavik")
rome <- import_climate_wiki("rome")
seattle <- import_climate_wiki("seattle")
victoria <- import_climate_wiki("victoria")

# Read other data
coordinates <- read.taf("boot/data/coordinates.csv")
new.bedford.sunshine <- read.taf("boot/data/new_bedford_sunshine.csv")
noumea.humidity <- read.taf("boot/data/noumea_humidity.csv")

# Convert coordinates from degree to numeric format
coordinates$North <- round(deg2num(coordinates$Lat), 4)
coordinates$East <- round(deg2num(coordinates$Lon), 4)

# Fill in gaps: sunshine, humidity
new.bedford$Sunshine.hours <- new.bedford.sunshine$Sunshine.hours *
  c(31, 28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
noumea$Humidity <- noumea.humidity$Humidity

# Construct list
cities <- list("Copenhagen"=copenhagen,
               "Fairbanks"=fairbanks,
               "Juneau"=juneau,
               "New Bedford"=new.bedford,
               "Noumea"=noumea,
               "Reykjavik"=reykjavik,
               "Rome"=rome,
               "Seattle"=seattle,
               "Victoria"=victoria)

# Temperature
temp <- data.frame(City=names(cities),
                   Summer.day=sapply(cities, \(x) max(x$Daily.max)),
                   Summer.night=sapply(cities, \(x) max(x$Daily.min)),
                   Winter.day=sapply(cities, \(x) min(x$Daily.max)),
                   Winter.night=sapply(cities, \(x) min(x$Daily.min)),
                   row.names=NULL)

# Write list and table
saveRDS(cities, "data/cities.rds")
write.taf(coordinates, dir="data")
write.taf(temp, dir="data")
