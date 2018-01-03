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