# Read the data
power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Filter for 1 and 2 February 2007
subset_data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

# Convert variables to numeric
subset_data$Global_active_power <- as.numeric(subset_data$Global_active_power)
subset_data$Global_reactive_power <- as.numeric(subset_data$Global_reactive_power)
subset_data$Voltage <- as.numeric(subset_data$Voltage)
subset_data$Sub_metering_1 <- as.numeric(subset_data$Sub_metering_1)
subset_data$Sub_metering_2 <- as.numeric(subset_data$Sub_metering_2)
subset_data$Sub_metering_3 <- as.numeric(subset_data$Sub_metering_3)

# Create datetime variable
datetime <- as.POSIXct(
  paste(subset_data$Date, subset_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

# Positions for day labels
tick_positions <- as.POSIXct(
  c(
    "2007-02-01 00:00:00",
    "2007-02-02 00:00:00",
    "2007-02-03 00:00:00"
  )
)

# Create PNG
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(
  datetime,
  subset_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power",
  xaxt = "n"
)
axis(
  1,
  at = tick_positions,
  labels = c("Thu", "Fri", "Sat")
)

# Plot 2: Voltage
plot(
  datetime,
  subset_data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage",
  xaxt = "n"
)
axis(
  1,
  at = tick_positions,
  labels = c("Thu", "Fri", "Sat")
)

# Plot 3: Energy Sub Metering
plot(
  datetime,
  subset_data$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering",
  xaxt = "n"
)

lines(datetime, subset_data$Sub_metering_2, col = "red")
lines(datetime, subset_data$Sub_metering_3, col = "blue")

axis(
  1,
  at = tick_positions,
  labels = c("Thu", "Fri", "Sat")
)

legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
  cex = 0.8
)

# Plot 4: Global Reactive Power
plot(
  datetime,
  subset_data$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global Reactive Power",
  xaxt = "n"
)

axis(
  1,
  at = tick_positions,
  labels = c("Thu", "Fri", "Sat")
)

# Close PNG device
dev.off()
    
    
    
    
    