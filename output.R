## Extract results of interest, write TAF output tables

## Before: daylight.csv, temperature.csv, uv_cities.csv, uv_world_avg.csv,
##         uv_world_max.csv (model)
## After:  daylight.csv, temperature.csv, uv_cities.csv, uv_world_avg.csv,
##         uv_world_max.csv (output)

library(TAF)

mkdir("output")

cp("model/daylight.csv", "output")
cp("model/temperature.csv", "output")
cp("model/uv_cities.csv", "output")
cp("model/uv_world_avg.csv", "output")
cp("model/uv_world_max.csv", "output")
