# read data and name columns
PowerUse <- read.table("household_power_consumption.txt", skip = 1, sep = ";")
names(PowerUse) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#subset data for only 2007-02-01 and 2007-02-02
PowerUse_Sub <- subset(PowerUse, PowerUse$Date == "1/2/2007" | PowerUse$Date == "2/2/2007")

# make plot and save imgae
par(mfrow = c(1, 1))
hist(as.numeric(PowerUse_Sub$Global_active_power),
     col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
