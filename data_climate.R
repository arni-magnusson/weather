## Preprocess climate data, write TAF data tables

## Before: copenhagen.csv, fairbanks.csv, juneau.csv, new_bedford.csv,
##         noumea.csv, reykjavik.csv, rome.csv, seattle.csv,
##         victoria.csv (boot/data)
## After:  climate.rds, temp.csv (data)

library(TAF)
source("utilities.R")  # import_climate_wiki

mkdir("data")

# Read climate tables
copenhagen <- import_climate_wiki("copenhagen")
fairbanks <- import_climate_wiki("fairbanks")
juneau <- import_climate_wiki("juneau")
new.bedford <- import_climate_wiki("new_bedford")
noumea <- import_climate_wiki("noumea")
reykjavik <- import_climate_wiki("reykjavik")
rome <- import_climate_wiki("rome")
seattle <- import_climate_wiki("seattle")
victoria <- import_climate_wiki("victoria")

# Read complimentary climate data: humidity
noumea.humidity <- read.taf("boot/data/noumea_humidity.csv")

# Fill in gaps: humidity
noumea$Humidity <- noumea.humidity$Humidity

# Construct list
climate <- list("Copenhagen"=copenhagen,
                "Fairbanks"=fairbanks,
                "Juneau"=juneau,
                "New Bedford"=new.bedford,
                "Noumea"=noumea,
                "Reykjavik"=reykjavik,
                "Rome"=rome,
                "Seattle"=seattle,
                "Victoria"=victoria)

# Temperature
temp <- data.frame(City=names(climate),
                   Summer.day=sapply(climate, \(x) max(x$Daily.max)),
                   Summer.night=sapply(climate, \(x) max(x$Daily.min)),
                   Winter.day=sapply(climate, \(x) min(x$Daily.max)),
                   Winter.night=sapply(climate, \(x) min(x$Daily.min)),
                   row.names=NULL)

# Write list and table
saveRDS(climate, "data/climate.rds")
write.taf(temp, dir="data")
