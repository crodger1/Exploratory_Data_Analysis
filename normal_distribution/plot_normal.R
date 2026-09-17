# Create x values from -4 to 4 with at least 400 points
x_values <- seq(-4, 4, length.out = 400)

# Calculate y values using the standard normal density function
y_values <- dnorm(x_values)

# Open a PNG device to save the plot
png("normal_distribution/normal_distribution.png", width = 480, height = 480)

# Plot the standard normal distribution as a line with line width 2
plot(x_values, y_values, type = "l", lwd = 2, xlab = "x", ylab = "Density", main = "Standard Normal Distribution (mean = 0, sd = 1)")

# Shade the area between -1 and 1 under the curve with a light semi-transparent colour
polygon(c(-1, seq(-1, 1, length.out = 400), 1), c(0, dnorm(seq(-1, 1, length.out = 400)), 0), col = "#0000FF33")

# Draw a dashed vertical line at the mean (x = 0)
abline(v = 0, lty = "dashed")

# Close the PNG device
dev.off()
