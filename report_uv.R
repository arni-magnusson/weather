## Prepare UV index plot for report

## Before: coordinates.csv (data),
##         uv_cities.csv, uv_world_avg.csv, uv_world_max.csv (output)
## After:  uv_cities.png, uv_world_avg.png, uv_world_max.png (report)

library(TAF)
library(maps)

mkdir("report")

# Read data
coordinates <- read.taf("data/coordinates.csv")
uv.cities <- read.taf("output/uv_cities.csv", row.names=1)
uv.world.avg <- read.taf("output/uv_world_avg.csv")
uv.world.max <- read.taf("output/uv_world_max.csv")

# Reorder cities
uv.cities <- uv.cities[,order(sapply(uv.cities, max))]
coordinates <- coordinates[order(-abs(coordinates$North)),]

# Rearrange world surface
surface.avg <- xtabs(Index~East+North, uv.world.avg)
surface.max <- xtabs(Index~East+North, uv.world.max)
xcoords <- as.numeric(rownames(surface.avg))
ycoords <- as.numeric(colnames(surface.avg))

# Color palettes
col.uv <- colorRampPalette(c("#ffffff", "#e0c0b0", "#d06000", "#804000"))(20)
col.cities <- findInterval(sapply(uv.cities, max), c(0,8,12))
col.cities <- c(3, 7, 2)[col.cities]

# Plot UV index annual cycle for cities
taf.png("uv_cities_cycle")
matplot(uv.cities, type="l", lwd=1.5, xlab="Month", ylab="UV index")
dev.off()

# Plot maximum UV index for cities
taf.png("uv_cities_max")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(sapply(uv.cities, max), horiz=TRUE, las=TRUE, xlab="Maximum UV index",
        col=col.cities)
dev.off()

# World map of maximum UV index
taf.png("uv_world_avg", 1600, 1000)
image(xcoords, ycoords, surface.avg, ylim=c(-56, 72), col=col.uv,
      main="Average UV index",  xlab="", ylab="")
map(add=TRUE)
points(North~East, coordinates, pch=16, col=col.cities)
points(North~East, coordinates)
dev.off()

# World map of maximum UV index
taf.png("uv_world_max", 1600, 1000)
image(xcoords, ycoords, surface.max, ylim=c(-56, 72), col=col.uv,
      main="Maximum UV index", xlab="", ylab="")
map(add=TRUE)
points(North~East, coordinates, pch=16, col=col.cities)
points(North~East, coordinates)
dev.off()
