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