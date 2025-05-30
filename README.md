RNA-Seq data consists of counts (reads mapped to genes), which are discrete, non-negative integers. Because these counts are not continuous, we cannot model them using a normal distribution.

Why not Poisson distribution?
The Poisson distribution models count data where the mean equals the variance (one parameter: lambda).

In RNA-Seq, the variance is often greater than the mean — this is called overdispersion.

This extra variability comes from biological differences between samples (biological replicates) and technical variability.

Thus, the Poisson assumption of equal mean and variance does not hold.

Why Negative Binomial distribution?
DESeq2 uses the Negative Binomial (NB) distribution, which includes an extra parameter called dispersion.

This dispersion parameter accounts for the extra variability in RNA-Seq counts beyond Poisson noise.

This better models RNA-Seq data variability across biological replicates.

"Negative binomial is used because RNA-seq data shows more variability across samples, and NB accounts for this extra variance with a dispersion parameter."

What DESeq2 does (per gene)
1. Estimate size factors (normalization)
Different samples may have different sequencing depths.

Raw counts are also affected by gene length and other biases.

DESeq2 calculates size factors per sample to normalize counts, using the median of ratios method:

Compute the geometric mean of counts for each gene across all samples.

For each sample, calculate the ratio of the gene’s count to the geometric mean.

The median of these ratios for all genes in that sample is the size factor.

This approach normalizes sequencing depth robustly, minimizing the influence of highly expressed outlier genes.

2. Estimate dispersion
Dispersion measures the spread or variability of gene expression counts.

It helps distinguish:

True biological differences in gene expression across conditions.

Natural biological variability ("biological noise").

Genes with outlier variability have their dispersion estimates shrunk toward a fitted trend line to improve stability.

Some genes don’t follow this pattern, showing variance not explained by biological or technical variation.

3. Fit the model
DESeq2 fits a generalized linear model (GLM) per gene relating expression counts to experimental conditions (e.g., treated vs control).

4. Hypothesis testing
Tests if observed differences in gene expression between conditions are significant.

Provides p-values for the null hypothesis (no differential expression).

Multiple testing correction is applied to control false discovery rate (FDR), giving adjusted p-values.
