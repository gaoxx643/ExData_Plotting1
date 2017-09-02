# read table and name columns
data <- read.table("household_power_consumption.txt", skip = 1, sep = ";", stringsAsFactors = F)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset data and convert format
datasub <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02")) 
datetime <- paste(as.Date(datasub$Date), datasub$Time)
datasub$Datetime <- as.POSIXct(datetime)

# make plot
par(mfrow = c(1, 1), mar = c(0, 0.2, 0, 0.2))
with(datasub, {
        plot(Sub_metering_1~Datetime, type ="l", ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Sub_metering_2~Datetime, col = "red")
        lines(Sub_metering_3~Datetime, col = "blue")
})
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()