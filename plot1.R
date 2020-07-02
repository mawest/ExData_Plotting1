# Read data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Cleanup data
df[df == "?"] <- NA
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
for (i in 3:8) { df[, i] <- as.numeric(df[, i]) }

# Select the required time period (2 days)
df <- df[df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"),]

# Create the histogram
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Write the plot to a png file
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
dev.off()
