######
# plot4.R
# 
# Create "Plot 4" for the 1st Assigment of Exploratory Data Analysis
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
dfData$datetime <- as.POSIXct(strptime(dfData$dt, "%d/%m/%Y %H:%M:%S"))

# If following lines are not present in Windows the "factor" to "numeric" coherce is wrong
dfData$Sub_metering_1 <- as.numeric(as.character(dfData$Sub_metering_1))
dfData$Sub_metering_2 <- as.numeric(as.character(dfData$Sub_metering_2))
dfData$Sub_metering_3 <- as.numeric(as.character(dfData$Sub_metering_3))

dfData$Global_active_power <- as.numeric(as.character(dfData$Global_active_power))
dfData$Global_reactive_power <- as.numeric(as.character(dfData$Global_reactive_power))
dfData$Voltage <- as.numeric(as.character(dfData$Voltage))

# Create the chart and save it to a png file
png(filename="plot4.png", width=480, height=480)

# Define a layout for 2x2 charts
par(mfrow = c(2,2))

with(dfData, {
  
  # Plot (1,1) taken from plot2.R
  
  plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  # Plot (1,2)
  
  plot(datetime, Voltage, type="l")
  
  # Plot (2,1) taken from plot3.R
  plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
  points(datetime, Sub_metering_2, type="l", col="red")
  points(datetime, Sub_metering_3, type="l", col="blue")
  legend("topright", box.lty=0, inset=0.01, pch ="", lty=c(1,1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # Plot (2,2)
  
  plot(datetime, Global_reactive_power, type="l")

})

dev.off()