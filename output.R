## Extract results of interest, write TAF output tables

## Before: temperature.csv, uv_avg.csv, uv_cities.csv, uv_max.csv (model)
## After:  temperature.csv, uv_avg.csv, uv_cities.csv, uv_max.csv (output)

library(TAF)

mkdir("output")

cp("model/temperature.csv", "output")
cp("model/uv_avg.csv", "output")
cp("model/uv_cities.csv", "output")
cp("model/uv_max.csv", "output")
