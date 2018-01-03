#Read the data
data <- read.csv('household_power_consumption.txt', header=TRUE, sep=";")
#Transform date column to date type
data$Date <- as.Date(as.character(data$Date), '%d/%m/%Y')
#Transform time column to time type
data$Time <- format(strptime(data$Time, "%H:%M:%S"),"%H:%M:%S")
#Subset the data to take only dates of interest
subData <- subset(data, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
#Transform the remaining stuff to numeric type
subData$Global_active_power <- as.numeric(subData$Global_active_power)
subData$Voltage <- as.numeric(subData$Voltage)
subData$Global_reactive_power <- as.numeric(subData$Global_reactive_power)
subData$Sub_metering_1 <- as.numeric(subData$Sub_metering_1)
subData$Sub_metering_2 <- as.numeric(subData$Sub_metering_2)
subData$Sub_metering_3 <- as.numeric(subData$Sub_metering_3)
#Create a new column datetime which a concatenation of date and time columns
subData$DateTime <- strptime(
  paste(subData$Date, subData$Time, sep = " "),
  "%Y-%m-%d %H:%M:%S")
#plot 1
png("plot1.png", width = 480, height = 480, units = "px")
hist(subData$Global_active_power*2/1000, 
     col = "red", 
     xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power")
dev.off()
#plot 2
png("plot2.png", width = 480, height = 480, units = "px")
with(subData, plot(DateTime, Global_active_power*2/1000, ylab = "Global Active Power (kilowatts)", type="n"))
with(subData, lines(DateTime, Global_active_power*2/1000))
dev.off()
#plot 3
png("plot3.png", width = 480, height = 480, units = "px")
with(subData, plot(DateTime, Sub_metering_1, ylab = "Energy Sub metering", type="n"))
with(subData, lines(DateTime, Sub_metering_1, col = "black"))
with(subData, lines(DateTime, Sub_metering_2, col = "red"))
with(subData, lines(DateTime, Sub_metering_3, col = "blue"))
legend(pch = "_", "topright", col = c("black", "red", "blue"), legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
dev.off()
#plot 4
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2), mar=c(4,4,2,2))
with(subData, plot(DateTime, Global_active_power*2/1000, xlab="", ylab = "Global Active Power", type="n"))
with(subData, lines(DateTime, Global_active_power*2/1000))

with(subData, plot(DateTime, Voltage/10, ylab = "Voltage", xlab="datetime", type="n"))
with(subData, lines(DateTime, Voltage/10))

with(subData, plot(DateTime, Sub_metering_1, xlab="", ylab = "Energy Sub metering", type="n"))
with(subData, lines(DateTime, Sub_metering_1, col = "black"))
with(subData, lines(DateTime, Sub_metering_2, col = "red"))
with(subData, lines(DateTime, Sub_metering_3, col = "blue"))
legend(pch = "_", "topright", col = c("black", "red", "blue"), legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"))

with(subData, plot(DateTime, Global_reactive_power * 2/1000, ylab = "Voltage", xlab="datetime", type="n"))
with(subData, lines(DateTime, Global_reactive_power * 2/1000))
dev.off()