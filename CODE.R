

# 1. Load the dataset (Make sure to set your working directory to where the CSV is saved)
penguins_data <- read.csv("penguins.csv")

# 2. Check total observations (rows) and variables (columns)
dim(penguins_data)

# 3. Check variable names and data types
str(penguins_data)

# 4. View the first few observations to format your table
head(penguins_data)


# 1. Count missing values in the original dataset
colSums(is.na(penguins_data))

# 2. Subset the required columns
prepared_data <- penguins_data[, c("species", "bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")]

# 3. Check distribution skewness per species to decide between Mean and Median
# (If data is symmetrical, Mean is preferred. If highly skewed, Median is preferred)
by(prepared_data[-1], prepared_data$species, summary)

# 4. Impute missing values group-wise by Species using the Mean 
# (Note: Palmer Penguins numerical measurements are generally symmetric within species groups)
library(dplyr)

prepared_data <- prepared_data %>%
  group_by(species) %>%
  mutate(
    bill_length_mm = ifelse(is.na(bill_length_mm), mean(bill_length_mm, na.rm = TRUE), bill_length_mm),
    bill_depth_mm = ifelse(is.na(bill_depth_mm), mean(bill_depth_mm, na.rm = TRUE), bill_depth_mm),
    flipper_length_mm = ifelse(is.na(flipper_length_mm), mean(flipper_length_mm, na.rm = TRUE), flipper_length_mm),
    body_mass_g = ifelse(is.na(body_mass_g), mean(body_mass_g, na.rm = TRUE), body_mass_g)
  ) %>%
  ungroup()

# 5. Verify row counts and check for any remaining missing values
nrow(penguins_data)      # Count before
nrow(prepared_data)      # Count after
colSums(is.na(prepared_data)) # Verification check




# Define a helper function to calculate all required statistics
get_stats <- function(x) {
  c(
    Min = min(x),
    Q1 = quantile(x, 0.25)[[1]],
    Median = median(x),
    Mean = mean(x),
    Q3 = quantile(x, 0.75)[[1]],
    Max = max(x),
    SD = sd(x)
  )
}

# Apply the function to the four variables from your prepared dataset
summary_matrix <- sapply(prepared_data[, c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")], get_stats)

# Print the transposed, rounded matrix to copy the values easily
round(t(summary_matrix), 2)



#Setup a 2-row, 4-column plotting grid
par(mfrow = c(2, 4), mar = c(4, 4, 3, 1))

# Variables list for easy looping
vars <- c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")
titles <- c("Bill Length", "Bill Depth", "Flipper Length", "Body Mass")
units <- c("mm", "mm", "mm", "g")

# 1. Generate Histograms with Mean Lines
for(i in 1:4) {
  x <- prepared_data[[vars[i]]]
  m_val <- mean(x)
  
  hist(x, 
       main = paste("Hist of", titles[i]), 
       xlab = paste(titles[i], "(", units[i], ")"), 
       col = "skyblue", 
       border = "white")
  
  # Add the vertical red line for the mean
  abline(v = m_val, col = "red", lwd = 2, lty = 2)
}

# 2. Generate Boxplots
for(i in 1:4) {
  boxplot(prepared_data[[vars[i]]], 
          main = paste("Boxplot of", titles[i]), 
          ylab = paste(titles[i], "(", units[i], ")"), 
          col = "lightgreen")
}

# Reset plotting layout to default
par(mfrow = c(1, 1))





# 1. Calculate Pearson correlation coefficient
cor_s1 <- cor(prepared_data$flipper_length_mm, prepared_data$body_mass_g)
print(paste("Pearson Correlation:", round(cor_s1, 4)))

# 2. Fit the simple linear regression model (Model 1)
model1 <- lm(body_mass_g ~ flipper_length_mm, data = prepared_data)
summary(model1)


ggplot(prepared_data, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(alpha = 0.7, color = "#2c3e50", size = 2) + # Distinct data points
  geom_smooth(method = "lm", col = "#e74c3c", se = FALSE, lwd = 1.2) + # Red linear trend line
  labs(
    title = "Scatter Plot of Penguin Body Mass vs. Flipper Length",
    subtitle = "Scenario 1: Examining the Linear Relationship",
    x = "Flipper Length (mm)",
    y = "Body Mass (g)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )



# 3. Create predictions for given flipper lengths
new_flippers <- data.frame(flipper_length_mm = c(180, 190, 200, 210, 220))
predictions_s1 <- predict(model1, newdata = new_flippers, interval = "confidence")
cbind(new_flippers, predictions_s1)

# 4. Plot observed data, fitted regression line, and 95% confidence band
library(ggplot2)
ggplot(prepared_data, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  geom_smooth(method = "lm", col = "red", fill = "lightblue", level = 0.95) +
  labs(title = "Model 1: Regression of Body Mass on Flipper Length",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal()




# 1. Calculate Pearson correlation coefficient
cor_s2 <- cor(prepared_data$bill_length_mm, prepared_data$body_mass_g)
print(paste("Pearson Correlation:", round(cor_s2, 4)))

# 2. Fit the simple linear regression model (Model 2)
model2 <- lm(body_mass_g ~ bill_length_mm, data = prepared_data)
summary(model2)


ggplot(prepared_data, aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(alpha = 0.7, color = "#27ae60", size = 2) + # Distinct green data points
  geom_smooth(method = "lm", col = "#e74c3c", se = FALSE, lwd = 1.2) + # Red linear trend line
  labs(
    title = "Scatter Plot of Penguin Body Mass vs. Bill Length",
    subtitle = "Scenario 2: Examining the Linear Relationship",
    x = "Bill Length (mm)",
    y = "Body Mass (g)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )



# 3. Create predictions for given bill lengths
new_bills <- data.frame(bill_length_mm = c(35, 40, 45, 50, 55))
predictions_s2 <- predict(model2, newdata = new_bills, interval = "confidence")
cbind(new_bills, predictions_s2)

# 4. Plot observed data, fitted regression line, and 95% confidence band
library(ggplot2)
ggplot(prepared_data, aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(alpha = 0.6, color = "darkgreen") +
  geom_smooth(method = "lm", col = "red", fill = "lightgreen", level = 0.95) +
  labs(title = "Model 2: Regression of Body Mass on Bill Length",
       x = "Bill Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal()


# 1. Calculate Pearson correlation coefficient
cor_s3 <- cor(prepared_data$bill_depth_mm, prepared_data$flipper_length_mm)
print(paste("Pearson Correlation:", round(cor_s3, 4)))

# 2. Fit the simple linear regression model (Model 3)
model3 <- lm(flipper_length_mm ~ bill_depth_mm, data = prepared_data)
summary(model3)


ggplot(prepared_data, aes(x = bill_depth_mm, y = flipper_length_mm)) +
  geom_point(alpha = 0.7, color = "purple", size = 2) + # Distinct purple data points
  geom_smooth(method = "lm", col = "#e74c3c", se = FALSE, lwd = 1.2) + # Red linear trend line
  labs(
    title = "Scatter Plot of Penguin Flipper Length vs. Bill Depth",
    subtitle = "Scenario 3: Examining the Linear Relationship",
    x = "Bill Depth (mm)",
    y = "Flipper Length (mm)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )


# 3. Create predictions for given bill depths
new_depths <- data.frame(bill_depth_mm = c(14, 16, 18, 20, 22))
predictions_s3 <- predict(model3, newdata = new_depths, interval = "confidence")
cbind(new_depths, predictions_s3)

# 4. Plot observed data, fitted regression line, and 95% confidence band
library(ggplot2)
ggplot(prepared_data, aes(x = bill_depth_mm, y = flipper_length_mm)) +
  geom_point(alpha = 0.6, color = "purple") +
  geom_smooth(method = "lm", col = "red", fill = "lavender", level = 0.95) +
  labs(title = "Model 3: Regression of Flipper Length on Bill Depth",
       x = "Bill Depth (mm)",
       y = "Flipper Length (mm)") +
  theme_minimal()



# 1. Correlations among body mass and the three predictors
cor_matrix <- cor(prepared_data[, c("body_mass_g", "flipper_length_mm", "bill_length_mm", "bill_depth_mm")])
print(round(cor_matrix, 4))

# 2. Fit the Full Multiple Linear Regression Model
full_model <- lm(body_mass_g ~ flipper_length_mm + bill_length_mm + bill_depth_mm, data = prepared_data)
summary(full_model)


# 1. Extract the fitted (predicted) values from the full model
prepared_data$predicted_mass <- predict(full_model)

# 2. Create the Actual vs. Predicted scatter plot
ggplot(prepared_data, aes(x = predicted_mass, y = body_mass_g)) +
  geom_point(alpha = 0.7, color = "#2c3e50", size = 2) + 
  geom_abline(intercept = 0, slope = 1, col = "#e74c3c", lwd = 1.2, lty = 2) + # 45-degree reference line
  labs(
    title = "Bonus Model: Actual Body Mass vs. Predicted Body Mass",
    subtitle = "Evaluating the Full Multiple Linear Regression Model",
    x = "Predicted Body Mass (g)",
    y = "Actual Body Mass (g)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )



# 3. Model simplification (backward elimination)
# Remove bill_depth_mm (if it is the least significant)
reduced_model_1 <- lm(body_mass_g ~ flipper_length_mm + bill_length_mm, data = prepared_data)
summary(reduced_model_1)

# Compare Residual Standard Errors (RSE)
summary(full_model)$sigma
summary(reduced_model_1)$sigma
summary(model1)$sigma # Flipper-length-only model from Scenario 1