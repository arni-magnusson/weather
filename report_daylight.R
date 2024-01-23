## Prepare daylight plot for report

## Before: daylight.csv (output)
## After:  daylight.png (report)

library(TAF)

mkdir("report")

# Read results
daylight <- read.taf("output/daylight.csv")

# Reorder cities
daylight <- daylight[order(daylight$Shortest.day),]

# Plot shortest day
taf.png("daylight")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
barplot(daylight$Shortest.day, names=daylight$City, horiz=TRUE, las=1,
        xlab="Shortest day of the year (hrs)", ylab="")
dev.off()
