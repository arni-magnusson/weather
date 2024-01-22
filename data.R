## Preprocess data, write TAF data tables

## Before: copenhagen.csv, fairbanks.csv, juneau.csv, new_bedford.csv,
##         noumea.csv, reykjavik.csv, rome.csv, seattle.csv,
##         victoria.csv (boot/data)
## After:  cities.rds, temp.csv (data)

library(TAF)
source("utilities.R")

mkdir("data")

# Read data
copenhagen <- import("copenhagen")
fairbanks <- import("fairbanks")
juneau <- import("juneau")
new.bedford <- import("new_bedford")
noumea <- import("noumea")
reykjavik <- import("reykjavik")
rome <- import("rome")
seattle <- import("seattle")
victoria <- import("victoria")
new.bedford.sunshine <- read.taf("boot/data/new_bedford_sunshine.csv")
noumea.humidity <- read.taf("boot/data/noumea_humidity.csv")

# Fill in gaps
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
write.taf(temp, dir="data")
