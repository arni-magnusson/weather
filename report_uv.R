## Prepare UV index plot for report

## Before: uv_cities.csv, uv_world_avg.csv, uv_world_max.csv (output)
## After:  uv_cities.png, uv_world_avg.png, uv_world_max.png (report)

library(TAF)
library(maps)

mkdir("report")

# Read data

uv.cities <- read.taf("output/uv_cities.csv", row.names=1)
uv.world.avg <- read.taf("output/uv_world_avg.csv")
uv.world.max <- read.taf("output/uv_world_max.csv")

# Reorder cities
uv.cities <- uv.cities[,order(sapply(uv.cities, mean))]

# Rearrange world surface
surface.avg <- xtabs(Index~East+North, uv.world.avg)
surface.max <- xtabs(Index~East+North, uv.world.max)
xcoords <- as.numeric(rownames(surface.avg))
ycoords <- as.numeric(colnames(surface.avg))

# Plot UV index annual cycle for cities
taf.png("uv_cities_cycle")
matplot(uv.cities, type="l", lwd=1.5, xlab="Month", ylab="UV index")
dev.off()

# Plot maximum UV index for cities
taf.png("uv_cities_max")
par(plt=c(0.18, 0.9475, 0.17, 0.8633))
col <- rep(palette()[c(3, 7, 2)], c(4, 3, 2))
barplot(sapply(uv.cities, max), horiz=TRUE, las=TRUE, xlab="Maximum UV index",
        col=col)
dev.off()

# World map of maximum UV index
taf.png("uv_world_avg")
col <- colorRampPalette(c("#ffffff", "#e0c0b0", "#d06000", "#804000"))(20)
image(xcoords, ycoords, surface.avg, ylim=c(-56, 72), col=col, xlab="", ylab="",
      main="Average UV index")
map(add=TRUE)
dev.off()

# World map of maximum UV index
taf.png("uv_world_max")
col <- colorRampPalette(c("#ffffff", "#e0c0b0", "#d06000", "#804000"))(20)
image(xcoords, ycoords, surface.max, ylim=c(-56, 72), col=col, xlab="", ylab="",
      main="Maximum UV index")
map(add=TRUE)
dev.off()
