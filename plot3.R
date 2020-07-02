# Read data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Cleanup data
df[df == "?"] <- NA
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
for (i in 3:8) { df[, i] <- as.numeric(df[, i]) }

# Select the required time period (2 days)
df <- df[df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"),]

# Create the line plot with line for Sub_metering_1
plot(df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")

# Add lines for Sub_metering_2 and Sub_metering_3
lines(df$Sub_metering_2, col = "red")
lines(df$Sub_metering_3, col = "blue")

# Add days at x-axis
axis(1, at = c(1, 0.5 * dim(df)[1], dim(df)[1]), labels = c("Thu", "Fri", "Sat"))

# Add a legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.width = 750, y.intersp = 0.8)

# Write the plot to a png file
dev.copy(png, filename = "plot3.png", width = 480, height = 480)
dev.off()