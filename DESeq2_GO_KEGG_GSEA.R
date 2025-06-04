# Load necessary libraries
library(DESeq2)
library(tidyverse)
library(AnnotationDbi)
library(org.Hs.eg.db)     # Human gene annotation database
library(clusterProfiler)
library(enrichplot)

# Step 1: Load data
counts <- read.delim("https://www.ebi.ac.uk/gxa/experiments-content/E-MTAB-9479/resources/DifferentialSecondaryDataFiles.RnaSeq/raw-counts")
metadata <- read.delim("https://www.ebi.ac.uk/gxa/experiments-content/E-MTAB-9479/resources/ExperimentDesignFile.RnaSeq/experiment-design")

# Step 2: Prepare counts matrix
info <- counts[, c(1, 2)]
row.names(counts) <- counts$Gene.ID
counts <- counts[, -c(1, 2)]

# Step 3: Prepare metadata
metadata <- select(metadata, 1, 16)
metadata <- rename(metadata, stimulus = Sample.Characteristic.stimulus.)
rownames(metadata) <- metadata$Run

# Step 4: Verify matching of counts and metadata
all(colnames(counts) == rownames(metadata))
all(colnames(counts) %in% rownames(metadata))

# Step 5: Create DESeq2 dataset and preprocess
dds <- DESeqDataSetFromMatrix(countData = counts, colData = metadata, design = ~ stimulus)
dds <- dds[rowSums(counts(dds)) > 10, ]
dds$stimulus <- relevel(dds$stimulus, ref = "PBS")

# Step 6: Run DESeq2 differential expression analysis
dds <- DESeq(dds)
res <- results(dds, alpha = 0.05)
summary(res)
plotMA(res, alpha = 0.05)

# Step 7: Filter significant DE genes
res <- res[!is.na(res$padj), ]
res <- res[res$padj < 0.05, ]
res <- res[abs(res$log2FoldChange) > 1, ]

# Step 8: Annotate filtered genes
keys <- rownames(res)
columns_to_get <- c("ENTREZID", "GENENAME", "SYMBOL")
annotation <- select(org.Hs.eg.db, keys = keys, columns = columns_to_get, keytype = "ENSEMBL")

# Step 9: GO enrichment analysis - Cellular Component
go_group <- groupGO(gene = annotation$ENTREZID, OrgDb = org.Hs.eg.db, keyType = "ENTREZID", ont = "CC", level = 3, readable = TRUE)
barplot(go_group, drop = TRUE, showCategory = 10, title = "GO Level 3 - Cellular Component")

# Step 10: Detailed GO enrichment analysis (Molecular Function)
ego <- enrichGO(gene = annotation$ENTREZID, OrgDb = org.Hs.eg.db, keyType = "ENTREZID", ont = "MF", 
                pAdjustMethod = "BH", pvalueCutoff = 0.05, qvalueCutoff = 0.05, readable = TRUE)
head(ego)
barplot(ego, showCategory = 10, title = "Top 10 Enriched GO Terms")
dotplot(ego, showCategory = 10, title = "Top 10 Enriched GO Terms")
cnetplot(ego, showCategory = 5)

# Step 11: KEGG pathway enrichment analysis
kegg_enrich <- enrichKEGG(gene = annotation$ENTREZID, organism = 'hsa', pvalueCutoff = 0.05)
head(kegg_enrich)
dotplot(kegg_enrich, showCategory = 10, title = "KEGG Pathway Enrichment")

# Step 12: Prepare gene list for GSEA
annotation_filtered <- annotation[annotation$ENSEMBL %in% rownames(res), ]
genelist <- res$log2FoldChange[rownames(res) %in% annotation_filtered$ENSEMBL]
names(genelist) <- annotation_filtered$ENTREZID[match(rownames(res)[rownames(res) %in% annotation_filtered$ENSEMBL], annotation_filtered$ENSEMBL)]
genelist <- sort(genelist, decreasing = TRUE)

# Step 13: GSEA for KEGG pathways
gsea_kegg <- gseKEGG(geneList = genelist, organism = "hsa", minGSSize = 10, pvalueCutoff = 0.05, verbose = FALSE)
head(gsea_kegg)
dotplot(gsea_kegg, showCategory = 10, title = "GSEA KEGG Pathways")
ridgeplot(gsea_kegg)

# Step 14: GSEA for GO Biological Process
gsea_go <- gseGO(geneList = genelist, OrgDb = org.Hs.eg.db, ont = "BP", minGSSize = 10, pvalueCutoff = 0.05, verbose = FALSE)
head(gsea_go)
dotplot(gsea_go, showCategory = 10, title = "GSEA GO Biological Process")
ridgeplot(gsea_go)
