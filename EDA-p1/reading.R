data <- read.csv('household_power_consumption.txt', header=TRUE, sep=";")
head(data)
dim(data)
data$Date <- as.Date(as.character(data$Date), '%d/%m/%Y')
data$Time <- format(strptime(data$Time, "%H:%M:%S"),"%H:%M:%S")
head(data)
subData <- subset(data, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
subData$Global_active_power <- as.numeric(subData$Global_active_power)
head(subData)
subData$DateTime <- strptime(
  paste(subData$Date, subData$Time, sep = " "),
  "%Y-%m-%d %H:%M:%S")
hist(subData$Global_active_power*2/1000, 
     col = "red", 
     xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power")

with(subData, plot(DateTime, Global_active_power*2/1000, ylab = "Global Active Power (kilowatts)", type="n"))
with(subData, lines(DateTime, Global_active_power*2/1000))

with(subData, plot(DateTime, Sub_metering_1, ylab = "Energy Sub metering", type="n"))
with(subData, lines(DateTime, Sub_metering_1, col = "black"))
with(subData, lines(DateTime, Sub_metering_2, col = "red"))
with(subData, lines(DateTime, Sub_metering_3, col = "blue"))
legend(pch = "_", "topright", col = c("black", "red", "blue"), legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"))
