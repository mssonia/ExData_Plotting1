library(dplyr)
library(data.table)

# Load electric power consumption data
elecPwrConsumptnData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses=c(rep("character",2), rep("numeric",7)), blank.lines.skip = TRUE, na.strings="?")

# Convert Date from string to date
elecPwrConsumptnData$Date <- as.Date(elecPwrConsumptnData$Date, "%d/%m/%Y")

# Filter electric power consumption data and return only observations from 02/01/2007 to 02/02/2007
plotDataset <- subset(elecPwrConsumptnData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Initialize settings
png(filename="plot1.png", height=480, width=480, bg="transparent")

# Generate Histogram
hist(plotDataset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Save plot
dev.off()