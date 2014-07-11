######
# plot3.R
# 
# Create "Plot 3" for the 1st Assigment of Exploratory Data Analysis
#
#
# Personal testing on Windows:
# setwd("D:/Personal/R-examiningData/exploratory-assignment1")

Sys.setlocale("LC_TIME","English_United States.1252")   #Set the locale for printing of Date

myFile <- "./household_power_consumption.txt"

## OPTION 1. It works on Mac but I have issues in Windows
# library(sqldf)
# mySql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
# dfData <- read.csv2.sql(myFile,mySql)

## OPTION 2. Read all first and clean later
dfData <- read.csv2(myFile)
d1 <- dfData[dfData$Date == '1/2/2007',]
d2 <- dfData[dfData$Date == '2/2/2007',]
dfData <- rbind(d1,d2)


# Create new column for proper date formatting and representation
dfData$dt <- with(dfData, paste(Date, Time))
dfData$DateTime <- as.POSIXct(strptime(dfData$dt, "%d/%m/%Y %H:%M:%S"))

# If following lines are not present in Windows the "factor" to "numeric" coherce is wrong
dfData$Sub_metering_1 <- as.numeric(as.character(dfData$Sub_metering_1))
dfData$Sub_metering_2 <- as.numeric(as.character(dfData$Sub_metering_2))
dfData$Sub_metering_3 <- as.numeric(as.character(dfData$Sub_metering_3))

# Create the chart and save it to a png file
png(filename="plot3.png", width=480, height=480)
plot(dfData$DateTime, dfData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
points(dfData$DateTime, dfData$Sub_metering_2, type="l", col="red")
points(dfData$DateTime, dfData$Sub_metering_3, type="l", col="blue")
legend("topright", pch ="", lty=c(1,1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()