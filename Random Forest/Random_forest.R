# Load the necessary package
library(randomForest)
library(dplyr)

# Load the dataset
data <- read.csv("data.csv")

# Convert the time column
data$Time <- as.POSIXct(data$Time, format = "%H:%M")

# Extract temporal information (hour of the day)
data$day_hour <- as.numeric(format(data$Time, "%H"))

# Filter the data where visibility is less than or equal to 5
data <- data %>% filter(Visibility <= 5)

# Create a new variable by adding random noise to Visibility
data$Visibility_Img <- data$Visibility + rnorm(nrow(data), mean = 0, sd = 1)

# Split the dataset into training and testing sets
set.seed(42)
train_indices <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Use tuneRF to optimize parameters
rf_tune <- tuneRF(
  train_data[, c("Humidity", "Pressure", "Temperature", "day_hour", "Visibility_Img")],
  train_data$Visibility,
  trace = TRUE,             # Display progress
  mtryStart = 1,
  ntreeTry = 100,           # Number of trees to try
  stepFactor = 2,         # Increment factor
  improve = 0.001           # Required percentage improvement
)

# Extract the best mtry value from the matrix
best_mtry <- rf_tune[which.min(rf_tune[, 2]), 1]  # Column 1 contains mtry values, column 2 contains errors

# Train the final model with optimized parameters
rf_model <- randomForest(
  Visibility ~ Humidity + Pressure + Temperature + day_hour + Visibility_Img,
  data = train_data,
  ntree = 100,
  mtry = best_mtry,  # Set optimized mtry
  importance = TRUE
)

# Display the trained model
print(rf_model)

# Make predictions on the test set
predictions <- predict(rf_model, newdata = test_data)

# Compute Mean Squared Error and R-squared
mse <- mean((test_data$Visibility - predictions)^2)
r2 <- 1 - sum((test_data$Visibility - predictions)^2) / sum((test_data$Visibility - mean(test_data$Visibility))^2)

cat("Mean Squared Error:", mse, "\n")
cat("R² Score:", r2, "\n")

# Analyze the importance of variables in the prediction
# Extract variable importance from the model
importance_matrix <- importance(rf_model)
print(importance_matrix)

# Visualize the importance of each variable
varImpPlot(rf_model, main = "Variable Importance in Random Forest Model")

# Plot real vs predicted values
plot(test_data$Visibility, predictions, 
     main = "Real vs Predicted Visibility",
     xlab = "Real Visibility", 
     ylab = "Predicted Visibility",
     pch = 19, col = rgb(0, 0, 1, 0.3),  # Blue dots with transparency (alpha = 0.5)
     cex = 0.7)  # Reduce the point size (smaller dots)
abline(a = 0, b = 1, col = "red", lwd = 2)  # Add a reference line (y = x)

# Optionally, you can also add a line of best fit
lm_fit <- lm(predictions ~ test_data$Visibility)
abline(lm_fit, col = "green", lwd = 2)