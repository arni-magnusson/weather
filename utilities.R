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
  uv <- read.csv(path, header=FALSE)

  # Assign dimnames
  north <- seq(89.75, by=-0.5, length=360)
  east <- seq(-179.75, by=0.5, length=720)
  dimnames(uv) <- list(north, east)

  # Rearrange data frame
  uv <- xtab2long(uv, c("North", "East", "Index"))
  uv <- data.frame(uv[1:2], Month=as.integer(month), uv[3])

  uv
}

################################################################################

## Look up UV values for a location
## Requires lookup (UV index values) and optionally cities (coordinates)
## Example: lookup_uv("Reykjavik")         # using 'cities'
##          or lookup_uv(64.1467, -21.94)  # using 'north' and 'south'

lookup_uv <- function(north, east, lookup=uv, cities=coordinates)
{
  if(is.character(north))
  {
    east <- cities$East[cities$City == north]
    north <- cities$North[cities$City == north]
  }

  north.vec <- sort(unique(lookup$North))
  east.vec <- sort(unique(lookup$East))
  n <- north.vec[which.min(abs(north.vec - north))]  # 60N->59.75N, 60S->60.25S
  e <- east.vec[which.min(abs(east.vec - east))]  # 100W->100.25W, 100E->99.75E

  index <- lookup$Index[lookup$North==n & lookup$East==e]
  index <- setNames(index, month.abb)
  index
}
