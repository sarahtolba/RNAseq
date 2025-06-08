# Load required libraries
library(tidyverse)
library(pheatmap)
library(RColorBrewer)

# Step 1: Load data
counts <- read.delim("https://www.ebi.ac.uk/gxa/experiments-content/E-MTAB-5243/resources/DifferentialSecondaryDataFiles.RnaSeq/raw-counts")
metadata <- read.delim("https://www.ebi.ac.uk/gxa/experiments-content/E-MTAB-5243/resources/ExperimentDesignFile.RnaSeq/experiment-design")

# Step 2: Prepare counts matrix
info <- counts[, c(1, 2)]
row.names(counts) <- make.unique(as.character(counts$Gene.Name))
counts <- counts[, -c(1, 2)]

# Step 3: Prepare metadata
metadata <- select(metadata, 1, 8)
metadata <- rename(metadata, mode = Sample.Characteristic.genetic.modification.)
metadata <- as.data.frame(metadata)
metadata <- metadata[, -1]
rownames(metadata) <- colnames(counts)
metadata <- rename(metadata, mode = "metadata")

# Step 4: Convert counts to matrix
class(counts)      # Check class before conversion
counts <- as.matrix(counts)
class(counts)      # Check class after conversion
dim(counts)        # Dimensions of matrix

# Step 5: Select most variable genes
var <- apply(counts, MARGIN = 1, FUN = var)
var.df <- as.data.frame(var)
selected.genes <- names(var[order(var, decreasing = TRUE)][1:100])
final.counts <- counts[selected.genes, ]

# Step 6: Heatmap visualization
pheatmap(
  mat = final.counts,
  scale = "row",
  cutree_cols = 2,
  fontsize_row = 6,
  main = "My heat map",
  color = brewer.pal(n = 8, name = "PuRd"),
  annotation_col = metadata
)
