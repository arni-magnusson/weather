## Prepare climate plots for report

## Before: climate.rds (data)
## After:  humidity.png, precipitation.png, precipitation_days.png,
##         sunshine.png, snowfall.png, snowy_days.png (report)

library(TAF)

mkdir("report")

# Read data
climate <- readRDS("data/climate.rds")

# Extract climate variables
humidity <- sapply(climate, \(x) x$Humidity)
humidity <- sort(colMeans(humidity))
precipitation <- sapply(climate, \(x) x$Precipitation)
precipitation <- sort(colSums(precipitation))
precipitation.days <- sapply(climate, \(x) x$Precipitation.days)
precipitation.days <- sort(colSums(precipitation.days))
sunshine <- sapply(climate, \(x) x$Sunshine.hours)
sunshine <- sort(colSums(sunshine))
snowfall <- sapply(c("Fairbanks","Juneau","Paris","Reykjavik","Seattle",
                     "St. John's","Washington"), \(x) climate[[x]]$Snowfall)
snowfall <- sort(colSums(snowfall))
snowy.days <- sapply(c("Copenhagen","Fairbanks","Juneau","Paris","Reykjavik",
                       "Seattle","St. John's","Washington"),
                     \(x) climate[[x]]$Snowy.days)
snowy.days <- sort(colSums(snowy.days))

# Plot humidity
taf.png("humidity")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(humidity, horiz=TRUE, las=1, xlab="Average humidity (%)")
dev.off()

# Plot precipitation
taf.png("precipitation")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(precipitation/10, horiz=TRUE, las=1, xlab="Precipitation per year (cm)")
dev.off()

# Plot precipitation days
taf.png("precipitation_days")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(precipitation.days, horiz=TRUE, las=1,
        xlab="Precipitation days per year", xlim=c(0, 250))
dev.off()

# Plot snowfall
taf.png("snowfall")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(snowfall, horiz=TRUE, las=1, xlab="Snowfall per year (cm)",
        xlim=c(0, 350))
dev.off()

# Plot snowy days
taf.png("snowy_days")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(snowy.days, horiz=TRUE, las=1, xlab="Snowy days per year",
        xlim=c(0, 80))
dev.off()

# Plot sunshine
taf.png("sunshine")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(sunshine, horiz=TRUE, las=1, xlab="Sunshine per year (hrs)")
dev.off()
