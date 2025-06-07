# Load required libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggsci)

# Read data
ranges <- read.csv("../Desktop/python/ranges.csv", row.names = 2)
ranges <- ranges[, -1]

# Inspect structure of data
str(ranges)

# Filter data for selected chromosomes
mod.ranges <- filter(ranges, chromosome_name %in% c("chr1", "chr2", "chr3", "chr4", "chr5"))

# ---- Bar plot ----
# General notes for Bar Plot:
# - Requires: x as a categorical variable
# - Optional: fill as a categorical variable to differentiate groups by color
# - Purpose: Shows counts/frequencies of categories (distribution of categorical data)

ggplot(mod.ranges, aes(x = chromosome_name, fill = chromosome_name)) +
  geom_bar(width = 0.5) +
  theme_light() +
  scale_fill_manual(values = ggsci::pal_cosmic()(5)) +
  labs(title = "Distribution of Selected Chromosomes", x = "Chromosome", y = "Count")

# ---- Histogram ----
# General notes for Histogram:
# - Requires: x as a numeric variable
# - Purpose: Shows distribution and frequency of numeric data by binning values

ggplot(mod.ranges, aes(x = log2FoldChange)) +
  geom_histogram(binwidth = 1.5, fill = "pink", colour = "black") +
  theme_light() +
  labs(title = "Expression Distribution (log2FoldChange)", x = "log2FoldChange", y = "Frequency")

# ---- Scatter plot ----
# General notes for Scatter Plot:
# - Requires: numeric variables for both x and y axes
# - Optional: colour or shape for grouping or categorizing points
# - Purpose: Visualizes correlation or relationship between two numeric variables

ggplot(mod.ranges, aes(x = stat, y = baseMean, colour = chromosome_name)) +
  geom_point() +
  theme_light() +
  facet_grid(~chromosome_name) +
  labs(title = "Scatter Plot of Stat vs BaseMean by Chromosome",
       x = "Stat",
       y = "Base Mean")

# ---- Box plot ----
# General notes for Box Plot:
# - Requires: x as a categorical variable, y as a numeric variable
# - Optional: fill as a categorical variable for colors
# - Purpose: Displays summary statistics (median, quartiles, outliers) for numeric data grouped by categories

ggplot(mod.ranges, aes(x = chromosome_name, y = baseMean, fill = chromosome_name)) +
  geom_boxplot() +
  theme_light() +
  ylim(0, 500) +
  labs(title = "Boxplot of Base Mean by Chromosome",
       x = "Chromosome",
       y = "Base Mean")

# ---- Violin plot ----
# General notes for Violin Plot:
# - Requires: x as a categorical variable, y as a numeric variable
# - Optional: fill as a categorical variable for colors
# - Purpose: Shows distribution density plus summary statistics for numeric data grouped by categories

ggplot(mod.ranges, aes(x = chromosome_name, y = baseMean, fill = chromosome_name)) +
  geom_violin() +
  theme_light() +
  ylim(0, 500) +
  labs(title = "Violin Plot of Base Mean by Chromosome",
       x = "Chromosome",
       y = "Base Mean")
