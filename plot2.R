library(dplyr)
library(data.table)

# Load electric power consumption data
elecPwrConsumptnData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses=c(rep("character",2), rep("numeric",7)), blank.lines.skip = TRUE, na.strings="?")

# Filter electric power consumption data and return only observations from 02/01/2007 to 02/02/2007
plotDataset <- subset(elecPwrConsumptnData, subset=(as.Date(elecPwrConsumptnData$Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(elecPwrConsumptnData$Date, "%d/%m/%Y") <= "2007-02-02"))

# Create a timestamp column
plotDataset$Datetime <- as.POSIXct(strptime(paste(plotDataset$Date, plotDataset$Time), "%d/%m/%Y %H:%M:%S"))

# Get weekday based on timestamp
plotDataset$Day <- as.factor(weekdays(plotDataset$Datetime))

# Convert Date from string to date
plotDataset$Date <- as.Date(plotDataset$Date, "%d/%m/%Y")

# Initialize plot settings
png(filename="plot2.png", height=480, width=480, bg="transparent")

# Generate Graph plot
plot(plotDataset$Datetime, plotDataset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Save plot
dev.off()


