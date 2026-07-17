power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

subset_data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

subset_data$Global_active_power <- as.numeric(subset_data$Global_active_power)

datetime <- as.POSIXct(
  paste(subset_data$Date, subset_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

png("plot2.png", width = 480, height = 480)

# Plot without default x-axis
plot(
  datetime,
  subset_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)",
  xaxt = "n"
)

# Positions at midnight of each day
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

dev.off()
