# fetching zip-compressed file
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp);
data <- read.csv2(unz(temp, "household_power_consumption.txt"))
unlink(temp)
# subsetting
plotData <- subset(data, data$Date == '1/2/2007' | data$Date == '2/2/2007', drop = T)

plotData$Global_active_power <- as.numeric(as.character(plotData$Global_active_power))
plotData$dateTime <- strptime(paste(plotData$Date, plotData$Time), '%d/%m/%Y %H:%M:%S')

png(file="plot2.png",width=450,height=450)
plot(plotData$dateTime, plotData$Global_active_power,
     type='l', main='', ylab='Global Active Power (kilowatts)', xlab='', xaxt='n')
axis.POSIXct(1, plotData$dateTime, format='%a')
dev.off();