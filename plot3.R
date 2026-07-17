# Read the data
power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Keep only the required dates
subset_data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

# Convert sub-metering variables to numeric
subset_data$Sub_metering_1 <- as.numeric(subset_data$Sub_metering_1)
subset_data$Sub_metering_2 <- as.numeric(subset_data$Sub_metering_2)
subset_data$Sub_metering_3 <- as.numeric(subset_data$Sub_metering_3)

# Create datetime variable
datetime <- as.POSIXct(
  paste(subset_data$Date, subset_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

# Save plot
png("plot3.png", width = 480, height = 480)

# Plot first line
plot(
  datetime,
  subset_data$Sub_metering_1,
  type = "l",
  col = "pink",
  xlab = "",
  ylab = "Energy sub metering",
  xaxt = "n"
)

# Add remaining lines
lines(datetime, subset_data$Sub_metering_2, col = "purple")
lines(datetime, subset_data$Sub_metering_3, col = "blue")

# Custom x-axis labels
tick_positions <- as.POSIXct(
  c("2007-02-01 00:00:00",
    "2007-02-02 00:00:00",
    "2007-02-03 00:00:00")
)

axis(
  side = 1,
  at = tick_positions,
  labels = c("Thu", "Fri", "Sat")
)

# Legend in top-right corner
legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("pink", "purple", "blue"),
  lty = 1,
  bty = "n"
)

dev.off()
