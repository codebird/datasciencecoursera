library(dplyr)
library(quantmod)
library(lubridate)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'ss.csv')
df <- read.csv('ss.csv')
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'gdp.csv')
gdp <- read.csv('gdp.csv', skip=3, nrows=191)
gdp <- gdp[c(2:191),]
gdp <- mutate(gdp, US.dollars. = as.integer(gsub(',', '', US.dollars.)))
mean(gdp$US.dollars.)
grep("^United",gdp$Economy)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "fedstats.csv")
fedstats <- read.csv('fedstats.csv')
merged <- merge(gdp, fedstats, by.x = "X", by.y="CountryCode")

grep('^[Ff]iscal year end: [Jj]une', merged$Special.Notes)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(year(sampleTimes) == 2012)
sum(wday(sampleTimes, label = TRUE) == 'Mon' & year(sampleTimes) == 2012)