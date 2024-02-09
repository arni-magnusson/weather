## Preprocess climate data, write TAF data tables

## Before: copenhagen.csv, fairbanks.csv, juneau.csv, noumea.csv,
##         noumea_humidity.csv, reykjavik.csv, rome.csv, seattle.csv,
##         st_johns.csv, victoria.csv,
##         victoria_precipitation_days.csv (boot/data)
## After:  climate.rds (data)

library(TAF)
source("utilities.R")  # import_climate_wiki

mkdir("data")

# Read climate tables
copenhagen <- import_climate_wiki("copenhagen")
fairbanks <- import_climate_wiki("fairbanks")
juneau <- import_climate_wiki("juneau")
noumea <- import_climate_wiki("noumea")
reykjavik <- import_climate_wiki("reykjavik")
rome <- import_climate_wiki("rome")
seattle <- import_climate_wiki("seattle")
st.johns <- import_climate_wiki("st_johns")
victoria <- import_climate_wiki("victoria")

# Read complimentary climate data: humidity, precipitation days
noumea.humidity <- read.taf("boot/data/noumea_humidity.csv")
victoria.precipitation.days <-
  read.taf("boot/data/victoria_precipitation_days.csv")

# Fill in gaps: humidity
noumea$Humidity <- noumea.humidity$Humidity
victoria$Precipitation.days <- victoria.precipitation.days$Precipitation.days

# Construct list
climate <- list("Copenhagen"=copenhagen,
                "Fairbanks"=fairbanks,
                "Juneau"=juneau,
                "Noumea"=noumea,
                "Reykjavik"=reykjavik,
                "Rome"=rome,
                "Seattle"=seattle,
                "St. John's"=st.johns,
                "Victoria"=victoria)

# Write list
saveRDS(climate, "data/climate.rds")
