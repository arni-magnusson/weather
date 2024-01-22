## Preprocess UV index data, write TAF data tables

## Before: 01.csv, 02.csv, 03.csv, 04.csv, 05.csv, 06.csv,
##         07.csv, 08.csv, 09.csv, 10.csv, 11.csv, 12.csv (boot/data/uv)
## After:  uv.rds (data)

library(TAF)
source("utilities.R")  # import_uv_nasa

mkdir("data")

# Read UV index data
uv.01 <- import_uv_nasa(01)
uv.02 <- import_uv_nasa(02)
uv.03 <- import_uv_nasa(03)
uv.04 <- import_uv_nasa(04)
uv.05 <- import_uv_nasa(05)
uv.06 <- import_uv_nasa(06)
uv.07 <- import_uv_nasa(07)
uv.08 <- import_uv_nasa(08)
uv.09 <- import_uv_nasa(09)
uv.10 <- import_uv_nasa(10)
uv.11 <- import_uv_nasa(11)
uv.12 <- import_uv_nasa(12)

# Combine months
uv <- rbind(uv.01, uv.02, uv.03, uv.04, uv.05, uv.06,
            uv.07, uv.08, uv.09, uv.10, uv.11, uv.12)

# Write table
system.time(saveRDS(uv, "data/uv.rds"))  # CSV format takes too long, >10 sec
