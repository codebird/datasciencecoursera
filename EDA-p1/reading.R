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

with(subData, plot(DateTime, Global_active_power*2/1000, ylab="Global Active Power (kilowatts)", type="n"))
with(subData, lines(DateTime, Global_active_power*2/1000))
