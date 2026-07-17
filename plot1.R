# Read the data
power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Filter for 2007-02-01 and 2007-02-02
subset_data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

# Convert Global_active_power to numeric
subset_data$Global_active_power <- as.numeric(subset_data$Global_active_power)

# Prevent scientific notation on axes
options(scipen = 999)

# Save plot to PNG file
png("plot1.png", width = 480, height = 480)

# Plot histogram
hist(
  subset_data$Global_active_power,
  col = "blue",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency"
)

dev.off()
