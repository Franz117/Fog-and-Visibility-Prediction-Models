# 1. Loading data
data <- read.csv("data.csv")

cat("\nDescriptive statistics:\n")
print(summary(data))

# Convert date and time columns
data$Date <- as.Date(data$Date, format = "%Y-%m-%d")
data$Time <- as.POSIXct(data$Time, format = "%H:%M")

# Extract temporal information
data$day_hour <- as.numeric(format(data$Time, "%H"))
data$Month <- as.numeric(format(data$Date, "%m"))

# 3. Correlation analysis
cat("\nCorrelations with Visibility:\n")
cor_columns <- c("Visibility", "Temperature", "Humidity", "Pressure", "Wind", "Longitude", "Latitude", "day_hour", "Month")
cor_matrix <- cor(data[, cor_columns], use = "complete.obs")
visibility_correlations <- cor_matrix["Visibility", ]
print(visibility_correlations)

# Visualizing correlations with Visibility
library(ggplot2)
cor_data <- data.frame(Variable = names(visibility_correlations), Correlation = abs(visibility_correlations))
cor_data <- cor_data[cor_data$Variable != "Visibility", ]  # Exclude self-correlation

cor_plot <- ggplot(cor_data, aes(x = reorder(Variable, Correlation), y = Correlation)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
  coord_flip() +
  ggtitle("Correlations with Visibility") +
  xlab("Variables") +
  ylab("Absolute value of correlation") +
  theme_minimal()

print(cor_plot)

# Scatter plot: Visibility vs Humidity
scatter_plot <- ggplot(data, aes(x = Humidity, y = Visibility)) +
  geom_point(color = "blue", alpha = 0.7) +
  ggtitle("Visibility vs Humidity") +
  xlab("Humidity") +
  ylab("Visibility") +
  theme_minimal()

print(scatter_plot)

# 1. Loading data
file_path <- "data.csv"
data <- read.csv(file_path)

# 2. Data exploration
cat("First rows of the dataset:\n")
print(head(data))

cat("\nColumn information:\n")
print(str(data))

cat("\nDescriptive statistics:\n")
print(summary(data))

# Convert date and time columns (separate them if needed)
data$Date <- as.Date(data$Date, format = "%Y-%m-%d")
data$Time <- as.POSIXct(data$Time, format = "%H:%M")

# Extract temporal information
data$day <- format(data$Date, "%d")
data$month <- format(data$Date, "%m")
data$year <- format(data$Year, "%Y")
data$day_hour <- as.numeric(format(data$Time, "%H"))
data$Month <- as.numeric(format(data$Date, "%m"))

# Verify changes
cat("\nFirst rows with new temporal columns:\n")
print(head(data))

# 3. Correlation analysis
cat("\nCorrelations with Visibility:\n")
cor_columns <- c("Visibility", "Temperature", "Humidity", "Pressure", "Wind", "Longitude", "Latitude", "day_hour", "Month")
cor_matrix <- cor(data[, cor_columns], use = "complete.obs")
visibility_correlations <- cor_matrix["Visibility", ]
print(visibility_correlations)

# Visualizing correlations with Visibility
library(ggplot2)
cor_data <- data.frame(Variable = names(visibility_correlations), Correlation = visibility_correlations)
cor_data <- cor_data[cor_data$Variable != "Visibility", ]  # Exclude self-correlation

cor_plot <- ggplot(cor_data, aes(x = reorder(Variable, Correlation), y = Correlation)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
  coord_flip() +
  ggtitle("Correlations with Visibility") +
  xlab("Variables") +
  ylab("Correlation") +
  theme_minimal()

print(cor_plot)

# Scatter plot: Visibility vs Humidity
scatter_plot <- ggplot(data, aes(x = Humidity, y = Visibility)) +
  geom_point(color = "blue", alpha = 0.7) +
  ggtitle("Visibility vs Humidity") +
  xlab("Humidity") +
  ylab("Visibility") +
  theme_minimal()

print(scatter_plot)

# Histogram: Visibility values (0 to 10, intervals of 1)
histogram_0_10 <- ggplot(data, aes(x = Visibility)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  ggtitle("Distribution of Visibility (0 to 10)") +
  xlab("Visibility") +
  ylab("Frequency") +
  xlim(0, 11) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  theme_minimal()

print(histogram_0_10)

# Histogram: Visibility values (0 to 5, intervals of 0.5)
histogram_0_5 <- ggplot(data, aes(x = Visibility)) +
  geom_histogram(binwidth = 0.5, fill = "blue", color = "black", alpha = 0.7) +
  ggtitle("Distribution of Visibility (0 to 5)") +
  xlab("Visibility") +
  ylab("Frequency") +
  xlim(0, 5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  theme_minimal()

print(histogram_0_5)

# Histogram: Visibility values (0 to 1, intervals of 0.1)
histogram_0_1 <- ggplot(data, aes(x = Visibility)) +
  geom_histogram(binwidth = 0.1, fill = "blue", color = "black", alpha = 0.7) +
  ggtitle("Distribution of Visibility (0 to 1)") +
  xlab("Visibility") +
  ylab("Frequency") +
  xlim(0, 1) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  theme_minimal()

print(histogram_0_1)

# 4. Temporal analysis: Average visibility by hour of the day
library(dplyr)

cat("\nAverage visibility by hour of the day:\n")
hour_visibility <- data %>%
  group_by(day_hour) %>%
  summarise(mean_visibility = mean(Visibility, na.rm = TRUE))
print(hour_visibility)

# Plot average visibility by hour
ggplot(hour_visibility, aes(x = as.numeric(day_hour), y = mean_visibility)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  ggtitle("Average Visibility by Hour of the Day") +
  xlab("Hour of the Day") +
  ylab("Average Visibility") +
  theme_minimal()
