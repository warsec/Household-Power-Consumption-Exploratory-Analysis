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

#Plot1
xticks <- seq(0, 6, 2)
png("plot1.png", width = 480, height = 480)
hist(power_cons$Global_active_power/200, breaks = 13, col = 'red', xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

