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

# Initialize settings
png(filename="plot4.png", height=480, width=480, bg="transparent")
par(mfrow=c(2,2))

# Plot 1
plot(plotDataset$Datetime, plotDataset$Global_active_power, type="l", xlab="", ylab="Global_reactive_power")

# Plot 2  
plot(plotDataset$Datetime, plotDataset$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3  
plot(plotDataset$Datetime, plotDataset$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(plotDataset$Datetime, plotDataset$Sub_metering_2, col="red")
lines(plotDataset$Datetime, plotDataset$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

# Plot 4
plot(plotDataset$Datetime, plotDataset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save plot
dev.off()

