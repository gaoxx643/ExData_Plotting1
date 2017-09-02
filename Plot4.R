# read table and name columns
data <- read.table("household_power_consumption.txt", skip = 1, sep = ";", stringsAsFactors = F)
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                 "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset data and convert format
datasub <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02")) 
datetime <- paste(as.Date(datasub$Date), datasub$Time)
datasub$Datetime <- as.POSIXct(datetime)

# set number of rows and margin
par(mfrow=c(2,2))

# make plot
with(datasub, {
        plot(Global_active_power~Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
        plot(Voltage~Datetime, type = "l", ylab = "Voltage (volt)", xlab = "")
        plot(Sub_metering_1~Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Sub_metering_2~Datetime, col = "red")
        lines(Sub_metering_3~Datetime, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type = "l", ylab = "Global Reactive Power (kilowatts)", xlab = "")
        
})
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()