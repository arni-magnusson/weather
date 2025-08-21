## Prepare temperature plot for report

## Before: temperature.csv (output)
## After:  temperature.png (report)

library(TAF)

mkdir("report")

# Read results
temperature <- read.taf("output/temperature.csv")

# Rearrange temperature data
temperature <- taf2xtab(temperature)
temperature <- temperature[order(rowMeans(temperature)),]  # reorder cities
n <- nrow(temperature)

# Plot temperature
cex <- 1.3
pch <- 16
taf.png("temperature")
par(plt=c(0.1750, 0.9475, 0.1700, 0.8633))
plot(NA, xlim=range(temperature)+c(-2,2), ylim=c(1,n), ann=FALSE, axes=FALSE)
abline(v=seq(-30,30,by=5), lty=3, col="lightgray")
points(temperature$Summer.day,   1:n, cex=cex, pch=pch, col=1)
points(temperature$Summer.night, 1:n, cex=cex, pch=pch, col=2)
points(temperature$Winter.day,   1:n, cex=cex, pch=pch, col=3)
points(temperature$Winter.night, 1:n, cex=cex, pch=pch, col=4)
box()
axis(1)
axis(2, at=1:n, labels=rownames(temperature), las=1, tick=FALSE)
axis(3)
title(xlab="Temperature (C)")
legend("topleft", c("Summer day","Summer night","Winter day","Winter night"),
       pch=pch, col=1:4, bty="n", inset=0.02, y.intersp=1.25, cex=0.9)
dev.off()
