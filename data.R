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

# Construct list
cities <- list(copenhagen=copenhagen,
               fairbanks=fairbanks,
               juneau=juneau,
               new.bedford=new.bedford,
               noumea=noumea,
               reykjavik=reykjavik,
               rome=rome,
               seattle=seattle,
               victoria=victoria)

# Average temperature
temp <- data.frame(city=names(cities),
                   summer.day=sapply(cities, \(x) max(x$Daily.max)),
                   summer.night=sapply(cities, \(x) max(x$Daily.min)),
                   winter.day=sapply(cities, \(x) min(x$Daily.max)),
                   winter.night=sapply(cities, \(x) min(x$Daily.min)),
                   row.names=NULL)

# Write list and table
saveRDS(cities, "data/cities.rds")
write.taf(temp, dir="data")
