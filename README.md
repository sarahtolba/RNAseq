# RNA-Seq Analysis Using R

This bransh contains R scripts for RNA-Seq data processing, gene annotation, and differential expression analysis using DESeq2. The scripts are designed to be modular and clear, focusing on key steps for RNA-Seq workflows in R.

---

## 1. Data Processing and Gene Annotation

**Purpose:**  
Prepare RNA-Seq expression data for downstream analysis by reshaping, merging with metadata, and annotating gene identifiers.

**Key steps:**

- Load expression data (e.g., FPKM or counts) from CSV files.  
- Reshape data from wide to long format for easier manipulation.  
- Integrate sample metadata from GEO or other sources.  
- Extract top expressed genes for focused analysis.  
- Annotate gene IDs (e.g., Entrez IDs) with gene symbols, gene names, and Ensembl IDs using the appropriate Bioconductor annotation package (`org.Mm.eg.db` for mouse).  
- Export annotated data for further use.

**Packages used:**  
`tidyverse`, `GEOquery`, `org.Mm.eg.db`, `AnnotationDbi`, `dplyr`, `ggplot2`

**Usage notes:**  
- Ensure sample names match between expression data and metadata.  
- Use the correct organism-specific annotation package for your data.  
- Normalized values like FPKM are used here; raw counts are preferred for DE testing.

---

## 2. Differential Expression Analysis with DESeq2

**Purpose:**  
Identify genes with significant expression differences between groups using raw RNA-Seq count data.

**Key concepts:**  
- RNA-Seq counts are discrete and overdispersed (variance > mean), so DESeq2 models them with a Negative Binomial distribution that accounts for this extra variability.  
- DESeq2 normalizes counts using size factors to adjust for sequencing depth differences.  
- It estimates dispersion to model biological variability.  
- Fits a generalized linear model (GLM) per gene relating counts to experimental conditions.  
- Performs hypothesis testing with p-value adjustment for multiple testing (FDR).

**Packages used:**  
`DESeq2`

**Usage notes:**  
- Input must be raw counts, not normalized values.  
- Metadata should accurately reflect experimental design.  
- Output includes fold changes and adjusted p-values for each gene.

---

If you have any questions or suggestions, feel free to open an issue or contribute! [email : sarahtolba842@gmail.com]






