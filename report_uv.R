## Prepare UV index plot for report

## Before: uv_cities.csv (output)
## After:  uv_cities.png (report)

library(TAF)

mkdir("report")

# Read results
uv.cities <- read.taf("output/uv_cities.csv", row.names=1)

# Reorder cities
uv.cities <- uv.cities[,order(sapply(uv.cities, mean))]

# Plot annual cycle and maximum
taf.png("uv_cities", height=2400)
par(mfrow=c(2,1))
# annual cycle
matplot(uv.cities, type="l", lwd=1.5, xlab="Month", ylab="UV index")
# maximum
par(plt=c(0.18, 0.9475, 0.17, 0.8633))
col <- rep(palette()[c(3, 7, 2)], c(4, 3, 2))
barplot(sapply(uv.cities, max), horiz=TRUE, las=TRUE, xlab="Maximum UV index",
        col=col)
dev.off()
