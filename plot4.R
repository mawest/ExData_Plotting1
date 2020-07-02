# Read data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Cleanup data
df[df == "?"] <- NA
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
for (i in 3:8) { df[, i] <- as.numeric(df[, i]) }

# Select the required time period (2 days)
df <- df[df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"),]

# Specify a 2 by 2 plot layout
par(mfrow = c(2, 2))

# Create the first plot
plot(df$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n")
axis(1, at = c(1, 0.5 * dim(df)[1], dim(df)[1]), labels = c("Thu", "Fri", "Sat"))

# Create the second plot
plot(df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis(1, at = c(1, 0.5 * dim(df)[1], dim(df)[1]), labels = c("Thu", "Fri", "Sat"))

# Create the third plot
plot(df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(df$Sub_metering_2, col = "red")
lines(df$Sub_metering_3, col = "blue")
axis(1, at = c(1, 0.5 * dim(df)[1], dim(df)[1]), labels = c("Thu", "Fri", "Sat"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.width = 1500, box.lty = 0, y.intersp = 0.8)

# Create the fourth plot
plot(df$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
axis(1, at = c(1, 0.5 * dim(df)[1], dim(df)[1]), labels = c("Thu", "Fri", "Sat"))

# Write the plot to a png file
dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()