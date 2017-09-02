# read data and name columns
PowerUse <- read.table("household_power_consumption.txt", skip = 1, sep = ";", stringsAsFactors = F)
names(PowerUse) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
PowerUse$Date <- as.Date(PowerUse$Date, format = "%d/%m/%Y")

#subset data
PowerUse_sub <- subset(PowerUse, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(PowerUse)

# convert dates
datetime <- paste(as.Date(PowerUse_sub$Date), PowerUse_sub$Time)
PowerUse_sub$Datetime <- as.POSIXct(datetime)

# make plot2 and save image
par(mfrow = c(1, 1))
with(PowerUse_sub, plot(Global_active_power~PowerUse_sub$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()