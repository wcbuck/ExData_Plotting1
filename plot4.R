# get data from csv file
household_power_consumption <- read.csv("C:/Users/wbuck/Desktop/R_stuff/exploratory analysis/data/household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)

#subset data frame to only include two dates
hpc_to_use  <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007", "2/2/2007"), ]

#data comes in as strings, so convert all the fields that should be numeric to numeric 
hpc <- transform(hpc_to_use, Global_active_power = as.numeric(Global_active_power), 
                 Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage), 
                 Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric(Sub_metering_1),
                 Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3))

#convert the date field to actual date formats and create a combined datetime
hpc <- transform(hpc, Date = as.Date(Date, "%d/%m/%Y"))
hpc <- transform(hpc, datetime = as.character(paste(as.character(Date), Time)))
hpc <- transform(hpc, datetime = strptime(datetime, format = "%Y-%m-%d %H:%M:%S"))

png(filename = "Plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

par(mfrow = c(2,2))
plot(hpc$datetime, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(hpc$datetime, hpc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(hpc$datetime, hpc$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(hpc$datetime, hpc$Sub_metering_2, type = "l", col = "red")
points(hpc$datetime, hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(hpc$datetime, hpc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

dev.off()