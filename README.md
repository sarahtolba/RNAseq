RNA-Seq Analysis Using R
This repository contains R scripts for comprehensive RNA-Seq data analysis, including data processing, gene annotation, and differential expression analysis using the DESeq2 package. The scripts are modular and designed for easy expansion as new methods or data processing steps are added.

Table of Contents
1. Data Processing and Gene Annotation

2. Differential Expression Analysis with DESeq2


1. Data Processing and Gene Annotation
Purpose:
This script prepares raw or normalized RNA-Seq expression data (e.g., FPKM or counts) for downstream analysis by reshaping, merging with metadata, and annotating gene identifiers.

Key steps:

Data loading: Reads expression data from CSV files, typically with gene IDs in rows and samples in columns.

Data reshaping: Converts wide-format data (genes × samples) into a long format that is easier to manipulate and join with metadata.

Metadata integration: Joins expression data with sample metadata retrieved from GEO or another source to include experimental conditions and other annotations.

Selecting genes: Extracts the top genes by expression level (e.g., top 20 highest FPKM) for focused analysis or visualization.

Gene annotation: Maps gene identifiers (e.g., Entrez IDs) to gene symbols, gene names, and Ensembl IDs using the org.Mm.eg.db Bioconductor package (for mouse data).

Important: Use the correct organism annotation package depending on your species.

Exporting results: Saves annotated data to CSV files for use in further analyses or reporting.

Packages used:
tidyverse, GEOquery, org.Mm.eg.db, AnnotationDbi, dplyr, ggplot2

Usage notes:

Ensure sample names in the expression data exactly match those in metadata for successful joining.

When working with organisms other than mouse, replace org.Mm.eg.db with the appropriate annotation package (e.g., org.Hs.eg.db for human).

This script assumes normalized expression values like FPKM; raw counts are preferred for differential expression testing.

2. Differential Expression Analysis with DESeq2
Purpose:
To identify genes whose expression differs significantly between experimental groups using raw RNA-Seq count data.

Background:
RNA-Seq generates discrete count data representing how many sequencing reads map to each gene. These counts exhibit overdispersion — variability greater than expected from a Poisson model — due to biological differences and technical variability. DESeq2 models this data with a Negative Binomial distribution, incorporating a dispersion parameter to account for extra variability.

Key steps:

Normalization:
DESeq2 calculates size factors to normalize for sequencing depth differences between samples using a median-of-ratios method, which is robust to highly expressed genes.

Dispersion estimation:
Measures variance in counts beyond technical noise, helping distinguish true biological differences from noise.

Model fitting:
Fits a generalized linear model (GLM) per gene relating counts to experimental conditions.

Hypothesis testing:
Tests whether observed expression differences are statistically significant, adjusting for multiple comparisons using False Discovery Rate (FDR) correction.

Packages used:
DESeq2

Usage notes:

Input data must be raw counts, not normalized values (e.g., FPKM or TPM).

Metadata should include all relevant experimental factors.

The output includes fold changes, p-values, and adjusted p-values for each gene.



