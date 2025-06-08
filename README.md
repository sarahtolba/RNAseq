# This repo is designed as a step-by-step tutorial to teach RNA-seq analysis including :

* Reference genome and annotation download
* RNA-seq raw data download from SRA
* Quality control before trimming
* Adapter trimming and quality filtering
* Reference genome indexing
* Alignment of reads to the genome
* BAM file processing and indexing
* Gene-level quantification with featureCounts
* Visualization of chromosome distribution and expression data
* Heatmap generation of most variable genes from RNA-Seq counts
* Differential expression analysis using DESeq2
* Functional enrichment analyses with GO and KEGG pathways
* Gene Set Enrichment Analysis (GSEA)

---

## Scripts Overview

## 1. rna_seq_analysis.sh
* Performs FastQC on raw reads
* Trims paired-end reads using fastp
* Builds HISAT2 index for mouse genome (GRCm39)
* Aligns trimmed reads with HISAT2
* Converts SAM to sorted BAM and indexes with samtools
* Generates read counts per gene using featureCounts
* Outputs timing information

### 2. Chromosome Data Visualization

* **Purpose:** Visualize distributions and relationships in chromosome-related data using bar plots, histograms, scatter plots, boxplots, and violin plots.
* **Input:** A CSV file (`ranges.csv`) containing chromosome names and associated statistics like `log2FoldChange`, `stat`, and `baseMean`.
* **Key Visualizations:**

  * Bar plot of chromosome frequency
  * Histogram of `log2FoldChange` values
  * Scatter plot of `stat` vs `baseMean` per chromosome
  * Boxplot and violin plot of `baseMean` grouped by chromosome

---

### 3. Heatmap of Most Variable Genes

* **Purpose:** Identify the top 100 most variable genes across samples and visualize their expression patterns via a heatmap.
* **Input:** Raw count data and metadata from the EBI Expression Atlas (example experiment E-MTAB-5243).
* **Process:**

  * Load raw counts and metadata
  * Filter and select top variable genes by variance
  * Generate a heatmap scaled by gene (row) with hierarchical clustering of samples
* **Key libraries:** `pheatmap`, `RColorBrewer`, `tidyverse`

---

### 4. Differential Expression and Functional Enrichment Analysis

* **Purpose:** Conduct a comprehensive differential expression analysis and explore enriched biological functions and pathways.
* **Input:** Raw count data and metadata from EBI Expression Atlas (example experiment E-MTAB-9479).
* **Process:**

  * Preprocess counts and metadata, ensure proper matching
  * Run DESeq2 for differential expression analysis between conditions
  * Filter significant genes based on adjusted p-value and fold change
  * Annotate genes with human gene symbols and Entrez IDs
  * Perform GO enrichment (Cellular Component and Molecular Function)
  * Perform KEGG pathway enrichment
  * Conduct Gene Set Enrichment Analysis (GSEA) for KEGG and GO Biological Processes
* **Visualizations:** MA plot, barplots, dotplots, cnetplots, ridgeplots, and enrichment maps
* **Key libraries:** `DESeq2`, `clusterProfiler`, `org.Hs.eg.db`, `enrichplot`

---

## How to Use

1. **Setup environment:**

   Install required R packages:

   ```r
   install.packages(c("tidyverse", "pheatmap", "RColorBrewer"))
   BiocManager::install(c("DESeq2", "clusterProfiler", "org.Hs.eg.db", "enrichplot", "AnnotationDbi"))
   ```

2. **Prepare data:**

   * For chromosome visualization, place `ranges.csv` in the specified path.
   * The count and metadata files for RNA-Seq are fetched directly from the provided URLs in the scripts.
   * link to ranges.csv : https://drive.google.com/drive/folders/1KiGJPEhZwxqI2snOxTDia1_QimIEGYIy?usp=drive_link
3. **Run scripts sequentially or independently:**

   * Start with chromosome visualization to understand chromosome-specific distributions.
   * Next, run the heatmap script to visualize expression variability.
   * Finally, run the DESeq2 analysis and enrichment pipeline for functional interpretation.

---

## Outputs and Interpretation

* **Chromosome plots:** Summary views of chromosome frequencies and expression distributions.
* **Heatmap:** Visual cluster patterns of the most variable genes across samples.
* **DESeq2 Results:** Lists of differentially expressed genes with statistical significance.
* **GO/KEGG Enrichment:** Identification of biological processes, molecular functions, cellular components, and pathways affected.
* **GSEA:** Enriched pathways and gene sets ranked by expression change.

---

## Notes

* Make sure internet access is available when loading datasets from online sources.
* Adjust filtering parameters (e.g., variance threshold, p-value cutoff, fold change) based on dataset and biological questions.
* Customize plot aesthetics for publication-quality figures.

---

## Contact and Support

For issues, suggestions, or collaborations, please contact:

**\[Your Name]**
Email: sarahtolba842@gmail.com
