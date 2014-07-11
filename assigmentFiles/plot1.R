######
# plot1.R
# 
# Create "Plot 1" for the 1st Assigment of Exploratory Data Analysis
#
#
# Personal testing on Windows:
setwd("D:/Personal/R-examiningData/exploratory-assignment1")
#Sys.setlocale("LC_TIME","English_United States.1252")   #Set the locale for printing of Date

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

# Create the chart and save it to a png file
png(filename="plot1.png", width=480, height=480)

# Working on Mac
# hist(dfData$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")

# Working on Windows
hist(as.numeric(as.character(dfData$Global_active_power)), xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")

dev.off()


