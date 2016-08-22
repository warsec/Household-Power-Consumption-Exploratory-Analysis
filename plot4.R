#Read the data
household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = F, dec = ".")

#Convert Date and Time columns into POSixit
household_power_consumption$timestamp <- paste(household_power_consumption$Date, household_power_consumption$Time, "")
timestamp <- strptime(household_power_consumption$timestamp, format = "%d/%m/%Y %H:%M")
timestamp <- as.POSIXct(timestamp, format = "%m/%d/%Y %H:%M")
household_power_consumption$timestamp <- timestamp

#Data Subset
power_cons <- subset(household_power_consumption, household_power_consumption$timestamp >= as.POSIXct("2007-02-01 00:00") &
                       household_power_consumption$timestamp <= as.POSIXct("2007-02-02 23:59"))
power_cons[3:9] <- lapply(power_cons[3:9], as.numeric)

#Plot4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(power_cons$timestamp, power_cons$Global_active_power, type ='l', xlab = "", ylab = "Global Active Power (kilowatts)")
plot(power_cons$timestamp, power_cons$Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
plot(power_cons$timestamp, power_cons$Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xlab ="")
lines(power_cons$timestamp, power_cons$Sub_metering_3, type = 'l', col = "blue")
lines(power_cons$timestamp, power_cons$Sub_metering_2, type = 'l', col = "red")
legend("topright", c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'), lty = c(1,1,1), col = c('black','red','blue'))
plot(power_cons$timestamp, power_cons$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')
dev.off()