## Preprocess climate data, write TAF data tables

## Before: [cities].csv (boot/data)
## After:  climate.rds (data)

library(TAF)
source("utilities.R")  # import_climate_wiki

mkdir("data")

# Read climate tables
accra <- import_climate_wiki("accra")
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
noumea.humidity <- read.taf("boot/data/noumea_humidity.csv")
paris.snowfall <- read.taf("boot/data/paris_snowfall.csv")
victoria.precipitation.days <-
  read.taf("boot/data/victoria_precipitation_days.csv")

# Fill in climate data gaps
noumea$Humidity <- noumea.humidity$Humidity
paris$Snowfall <- paris.snowfall$Snowfall
victoria$Precipitation.days <- victoria.precipitation.days$Precipitation.days

# Construct list
climate <- list("Accra"=accra,
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
