# Task: plot a standard normal distribution in R

Write one new R script.
Do not modify any other file in this repository, including this one.

## Files

- Create `normal_distribution/plot_normal.R`.
- The script must write `normal_distribution/normal_distribution.png`.

## Requirements

1. Use base R graphics only. Do not use ggplot2 or any other package.
2. Do not call `setwd()`. The script is run from the repository root with
   `Rscript normal_distribution/plot_normal.R`.
3. Plot the standard normal density (mean 0, standard deviation 1):
   - x values from -4 to 4, using `seq()` with at least 400 points.
   - y values from `dnorm()`.
   - Draw it as a line (`type = "l"`), line width 2.
4. Shade the area between -1 and 1 under the curve with `polygon()`,
   using a light semi-transparent colour.
5. Draw a dashed vertical line at the mean (x = 0) with `abline()`.
6. Labels:
   - x-axis: "x"
   - y-axis: "Density"
   - title: "Standard Normal Distribution (mean = 0, sd = 1)"
7. Write the plot to the PNG with `png(..., width = 480, height = 480)`
   and close the device with `dev.off()`.
8. Add a short comment above each step explaining what it does.

## Done when

- Running `Rscript normal_distribution/plot_normal.R` from the repository root
  finishes without errors.
- `normal_distribution/normal_distribution.png` exists and shows a bell curve
  with the middle region shaded.
