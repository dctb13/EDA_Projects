# Please make sure to set working directory to where data file is located
# package requirements
require(chron)

# read in data
power_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                         colClasses = c(rep("character",2), rep("numeric",7)))

# convert date col from charater to date
power_data$Date <- as.POSIXlt(power_data$Date, format="%d/%m/%Y")
# convert time from character to time
power_data$Time <- chron(times = power_data$Time)

# subsetting data based on 1st Feb and 2nd Feb 2007
subset_power_data <- subset(power_data, power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02")

# create new variable with date and time combined for subset
datetime <- paste(as.Date(subset_power_data$Date), subset_power_data$Time)
subset_power_data$Datetime <- as.POSIXct(datetime)

# make plot and save as png, setting background to transparent as the images on github appear to have this
png("plot4.png", width=480, height=480)

par(bg = "transparent",mfrow = c(2, 2))

# plot for coordinate (1,1)
plot(subset_power_data$Datetime, subset_power_data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

# plot for coordinate (1,2)
plot(subset_power_data$Datetime, subset_power_data$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

# plot for coordinate (2,1)
plot(subset_power_data$Datetime, subset_power_data$Sub_metering_1, type = "l", xlab="", 
     ylab="Energy sub metering", col="black")
lines(subset_power_data$Datetime, subset_power_data$Sub_metering_2,type = "l", col="red")
lines(subset_power_data$Datetime, subset_power_data$Sub_metering_3, type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"), bty = "n")

# plot for coordinate (2,2)
plot(subset_power_data$Datetime, subset_power_data$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()