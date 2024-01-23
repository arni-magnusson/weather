## Prepare climate plots for report

## Before: climate.rds (data)
## After:  humidity.png (report)

library(TAF)

mkdir("report")

# Read data
climate <- readRDS("data/climate.rds")

# Extract humidity
humidity <- sapply(climate, function(x) x$Humidity)
humidity <- as.data.frame(humidity)
rownames(humidity) <- month.abb
humidity <- sort(colMeans(humidity))

# Plot humidity
taf.png("humidity")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(humidity, horiz=TRUE, las=1, xlab="Average humidity (%)")
par("plt")
dev.off()
