Got it! I’ll unify and organize your README content into a consistent, clear format with sections following the same pattern. Here’s a polished version:

---

# RNA-Seq Analysis Using R

This repository contains R scripts for RNA-Seq data processing, gene annotation, differential expression analysis using **DESeq2**, and functional enrichment analysis (GO and KEGG). The workflow is modular, reproducible, and focused on key steps of RNA-Seq analysis.

---

## 1. Data Processing and Gene Annotation

**Purpose:**
Prepare RNA-Seq expression data for downstream analysis by reshaping, merging with metadata, and annotating gene identifiers.

**Key steps:**

* Load expression data (e.g., FPKM or raw counts) from CSV or other formats.
* Reshape data from wide to long format for easier manipulation.
* Integrate sample metadata from GEO or other sources.
* Extract top expressed genes for focused analysis.
* Annotate gene IDs (e.g., Entrez, Ensembl) with gene symbols, gene names, and other identifiers using Bioconductor annotation packages (e.g., `org.Mm.eg.db` for mouse).
* Export annotated data for further use.

**Packages used:**
`tidyverse`, `GEOquery`, `org.Mm.eg.db`, `AnnotationDbi`, `dplyr`, `ggplot2`

**Usage notes:**

* Ensure sample names match between expression data and metadata.
* Use the correct organism-specific annotation package.
* Prefer raw counts over normalized values (like FPKM) for differential expression analysis.

---

## 2. Differential Expression Analysis with DESeq2

**Purpose:**
Identify genes with significant expression changes between experimental groups using raw RNA-Seq counts.

**Key concepts:**

* RNA-Seq counts are modeled with a Negative Binomial distribution to account for biological and technical variability.
* DESeq2 normalizes counts by size factors to adjust for sequencing depth.
* Dispersion estimation models variability among biological replicates.
* A generalized linear model (GLM) links counts to experimental conditions.
* Hypothesis testing is performed with multiple testing correction (FDR).

**Packages used:**
`DESeq2`

**Usage notes:**

* Input data must be raw counts, not normalized values.
* Metadata must accurately describe experimental design.
* Outputs include log2 fold changes and adjusted p-values per gene.

---

## 3. Enrichment Analysis and Visualization

**Purpose:**
Identify biological functions and pathways enriched in differentially expressed genes using Gene Ontology (GO) and KEGG databases.

**Key steps:**

* Perform GO enrichment for Biological Process, Molecular Function, and Cellular Component categories.
* Perform KEGG pathway enrichment analysis.
* Conduct Gene Set Enrichment Analysis (GSEA) on ranked gene lists using log2 fold changes.
* Visualize enrichment results via barplots, dotplots, ridgeplots, and cnetplots.

**Packages used:**
`clusterProfiler`, `enrichplot`, `AnnotationDbi`, `org.Hs.eg.db` (for human)

**Usage notes:**

* Ensure gene identifiers match the annotation database (e.g., Ensembl IDs).
* Adjust parameters such as p-value cutoff and minimum gene set size for sensitivity.
* Reference condition factor level should be set appropriately (default "PBS" in example).

---

## 4. Workflow Overview

* Load raw counts and sample metadata (e.g., from EBI ArrayExpress E-MTAB-9479).
* Filter low-count genes (default threshold: sum counts < 10).
* Perform differential expression analysis comparing conditions (e.g., stimulus vs. control).
* Annotate significant genes and conduct GO and KEGG enrichment.
* Run GSEA on all genes ranked by log2 fold change.
* Generate comprehensive visualizations for results interpretation.

---

## Requirements

* R version 4.0 or higher
* Bioconductor and CRAN packages:

  * `DESeq2`
  * `tidyverse`
  * `AnnotationDbi`
  * `org.Hs.eg.db` (or organism-specific package)
  * `clusterProfiler`
  * `enrichplot`

Install missing packages with:


install.packages("tidyverse")
BiocManager::install(c("DESeq2", "AnnotationDbi", "org.Hs.eg.db", "clusterProfiler", "enrichplot"))



## Input Data Format

* **Raw counts matrix:** Genes as rows (preferably Ensembl IDs), samples as columns.
* **Sample metadata:** Table containing sample names and experimental conditions.

---

## Output

* Differential expression results table (log2 fold changes, adjusted p-values).
* Enrichment analysis results for GO terms and KEGG pathways.
* GSEA results tables and plots.
* Visual plots for enriched terms/pathways (barplots, dotplots, ridgeplots, cnetplots).

---

## Notes

* Filtering thresholds, reference conditions, and cutoff parameters can be customized.
* Make sure gene IDs and annotation packages correspond to your organism and dataset.
* For best results, use raw counts for DE analysis instead of normalized values like FPKM.

---

## Contact

If you have any questions, issues, or suggestions, feel free to open an issue or contact me:
**Email:** [sarahtolba842@gmail.com](mailto:sarahtolba842@gmail.com)

---

