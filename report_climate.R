## Prepare climate plots for report

## Before: climate.rds (data)
## After:  humidity.png (report)

library(TAF)

mkdir("report")

# Read data
climate <- readRDS("data/climate.rds")

# Extract humidity
humidity <- sapply(climate, function(x) x$Humidity)
humidity <- sort(colMeans(humidity))

# Extract precipitation
prec <- sapply(climate, function(x) x$Precipitation)
prec <- rev(sort(colSums(prec)))

# Extract precipitation days
precdays <- sapply(climate, function(x) x$Precipitation.days)
precdays <- rev(sort(colSums(precdays)))

# Plot humidity
taf.png("humidity")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(humidity, horiz=TRUE, las=1, xlab="Average humidity (%)")
dev.off()

# Plot precipitation
taf.png("precipitation")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(prec/10, horiz=TRUE, las=1, xlab="Precipitation per year (cm)")
dev.off()

# Plot precipitation days
taf.png("precipitation_days")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(precdays, horiz=TRUE, las=1, xlab="Precipitation days per year",
        xlim=c(0,250))
dev.off()
