## Import climate data from Wikipedia
## Example: reykjavik <- import_climate_wiki("reykjavik")

import_climate_wiki <- function(city)
{
  path <- paste0("boot/data/", city, ".csv")
  x <- read.taf(path, row.names=1)
  x <- as.data.frame(t(x[1:12]))
  names(x) <- make.names(names(x))
  x
}

################################################################################

## Import global UV index data from NASA
## Example: uv.01 <- import_uv_nasa(1)
## Output: North East Month Index

import_uv_nasa <- function(month)
{
  library(TAF)  # xtab2long

  # Read data
  path <- paste0("boot/data/uv/", sprintf("%02d", month), ".csv")
  month <- read.csv(path, header=FALSE)

  # Assign dimnames
  north <- seq(89.75, by=-0.5, length=360)
  east <- seq(-179.75, by=0.5, length=720)
  dimnames(month) <- list(north, east)

  # Rearrange data frame
  month <- xtab2long(month, c("North", "East", "Index"))
  month <- data.frame(month[1:2], Month=1L, month[3])

  month
}
