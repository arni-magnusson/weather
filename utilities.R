## Import climate table from Wikipedia
## Example: reykjavik <- import_climate_wiki("reykjavik")

import_climate_wiki <- function(city)
{
  path <- paste0("boot/data/", city, ".csv")
  x <- read.taf(path, row.names=1)
  x <- as.data.frame(t(x[1:12]))
  names(x) <- make.names(names(x))
  x
}
