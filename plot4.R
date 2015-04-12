# fetching zip-compressed file
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp);
data <- read.csv2(unz(temp, "household_power_consumption.txt"))
unlink(temp)
# subsetting
plotData <- subset(data, data$Date == '1/2/2007' | data$Date == '2/2/2007', drop = T)
# processing data
plotData$dateTime <- strptime(paste(plotData$Date, plotData$Time), '%d/%m/%Y %H:%M:%S')

plotData$Global_active_power <- as.numeric(as.character(plotData$Global_active_power))

plotData$Global_reactive_power <- as.numeric(as.character(plotData$Global_reactive_power))

plotData$Voltage <- as.numeric(as.character(plotData$Voltage))

plotData$Sub_metering_1 <- as.numeric(as.character(plotData$Sub_metering_1))
plotData$Sub_metering_2 <- as.numeric(as.character(plotData$Sub_metering_2))
plotData$Sub_metering_3 <- as.numeric(as.character(plotData$Sub_metering_3))

# creating plot

png(file="plot4.png",width=450,height=450)
par(mfrow = c(2, 2))
plot(plotData$dateTime, plotData$Global_active_power,
     type='l', main='', ylab='Global Active Power (kilowatts)', xlab='', xaxt='n')
axis.POSIXct(1, plotData$dateTime, format='%a')

plot(plotData$dateTime, plotData$Voltage,
     type='l', main='', ylab='Voltage', xaxt='n', xlab='')
axis.POSIXct(1, plotData$dateTime, format='%a')

plot(plotData$dateTime, plotData$Sub_metering_1, main='', ylab='Energy sub metering', type='l', xlab='')
lines(plotData$dateTime, plotData$Sub_metering_2, col='red')
lines(plotData$dateTime, plotData$Sub_metering_3, col='blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('grey', 'red', 'blue'), lty='solid')

plot(plotData$dateTime, plotData$Global_reactive_power,
     type='l', main='',
     ylab='Global_reactive_power', xlab='datetime',
     xaxt='n')
axis.POSIXct(1, plotData$dateTime, format='%a')

dev.off()