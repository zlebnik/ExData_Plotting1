# fetching zip-compressed file
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp);
data <- read.csv2(unz(temp, "household_power_consumption.txt"))
unlink(temp)
# subsetting
plotData <- subset(data, data$Date == '1/2/2007' | data$Date == '2/2/2007', drop = T)
plotData$dateTime <- strptime(paste(plotData$Date, plotData$Time), '%d/%m/%Y %H:%M:%S')

plotData$Sub_metering_1 <- as.numeric(as.character(plotData$Sub_metering_1))
plotData$Sub_metering_2 <- as.numeric(as.character(plotData$Sub_metering_2))
plotData$Sub_metering_3 <- as.numeric(as.character(plotData$Sub_metering_3))

png(file="plot3.png",width=450,height=450)
plot(plotData$dateTime, plotData$Sub_metering_1, main='', ylab='Energy sub metering', type='l', xlab='')
lines(plotData$dateTime, plotData$Sub_metering_2, col='red')
lines(plotData$dateTime, plotData$Sub_metering_3, col='blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('grey', 'red', 'blue'), lty='solid')
dev.off()