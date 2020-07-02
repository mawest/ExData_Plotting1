# Read data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Cleanup data
df[df == "?"] <- NA
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
for (i in 3:8) { df[, i] <- as.numeric(df[, i]) }

# Select the required time period (2 days)
df <- df[df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"),]

# Create the line plot
plot(df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")

# Add days at x-axis
axis(1, at = c(1, 0.5 * dim(df)[1], dim(df)[1]), labels = c("Thu", "Fri", "Sat"))

# Write the plot to a png file
dev.copy(png, filename = "plot2.png", width = 480, height = 480)
dev.off()