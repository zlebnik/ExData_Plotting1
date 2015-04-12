# fetching zip-compressed file
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp);
data <- read.csv2(unz(temp, "household_power_consumption.txt"))
unlink(temp)
# subsetting
plotData <- subset(data, data$Date == '1/2/2007' | data$Date == '2/2/2007', drop = T)
# creating plot
plotData$Global_active_power <- as.numeric(as.character(plotData$Global_active_power))

png(file="plot1.png",width=450,height=450)
hist(plotData$Global_active_power,
     col='red', main='Global Active Power',
     xlab='Global Active Power (kilowatts)'
     )
dev.off()