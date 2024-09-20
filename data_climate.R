## Preprocess climate data, write TAF data tables

## Before: bozeman.csv, bozeman_humidity.csv, bozeman_sunshine.csv,
##         copenhagen.csv, fairbanks.csv, juneau.csv, noumea.csv,
##         noumea_humidity.csv, paris.csv, paris_snowfall.csv, reykjavik.csv,
##         rome.csv, seattle.csv, st_johns.csv, victoria.csv,
##         victoria_precipitation_days.csv, washington.csv (boot/data)
## After:  climate.rds (data)

library(TAF)
source("utilities.R")  # import_climate_wiki

mkdir("data")

# Read climate tables
bozeman <- import_climate_wiki("bozeman")
copenhagen <- import_climate_wiki("copenhagen")
fairbanks <- import_climate_wiki("fairbanks")
juneau <- import_climate_wiki("juneau")
noumea <- import_climate_wiki("noumea")
paris <- import_climate_wiki("paris")
reykjavik <- import_climate_wiki("reykjavik")
rome <- import_climate_wiki("rome")
seattle <- import_climate_wiki("seattle")
st.johns <- import_climate_wiki("st_johns")
victoria <- import_climate_wiki("victoria")
washington <- import_climate_wiki("washington")

# Read complimentary climate data
bozeman.humidity <- import_climate_wiki("bozeman_humidity")
bozeman.sunshine <- import_climate_wiki("bozeman_sunshine")
noumea.humidity <- read.taf("boot/data/noumea_humidity.csv")
paris.snowfall <- read.taf("boot/data/paris_snowfall.csv")
victoria.precipitation.days <-
  read.taf("boot/data/victoria_precipitation_days.csv")

# Fill in climate data gaps
bozeman$Humidity <- bozeman.humidity$Humidity
bozeman$Sunshine.hours <- bozeman.sunshine$Sunshine.hours
noumea$Humidity <- noumea.humidity$Humidity
paris$Snowfall <- paris.snowfall$Snowfall
victoria$Precipitation.days <- victoria.precipitation.days$Precipitation.days

# Construct list
climate <- list("Bozeman"=bozeman,
                "Copenhagen"=copenhagen,
                "Fairbanks"=fairbanks,
                "Juneau"=juneau,
                "Noumea"=noumea,
                "Paris"=paris,
                "Reykjavik"=reykjavik,
                "Rome"=rome,
                "Seattle"=seattle,
                "St. John's"=st.johns,
                "Victoria"=victoria,
                "Washington"=washington)

# Write list
saveRDS(climate, "data/climate.rds")
