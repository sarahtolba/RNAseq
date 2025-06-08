# RNA-seq Analysis Pipeline Overview

This repository provides **bash scripts** for a complete RNA-seq workflow. It covers the following steps:

* Reference genome and annotation download
* RNA-seq raw data download from SRA
* Quality control before trimming
* Adapter trimming and quality filtering
* Reference genome indexing
* Alignment of reads to the genome
* BAM file processing and indexing
* Gene-level quantification with featureCounts

---

## Scripts

### 1. `rna_seq_analysis.sh`

* Performs **FastQC** on raw reads
* Trims paired-end reads using **fastp**
* Builds HISAT2 index for mouse genome (GRCm39)
* Aligns trimmed reads with HISAT2
* Converts SAM to sorted BAM and indexes with **samtools**
* Generates read counts per gene using **featureCounts**
* Outputs timing information

> **Note:** Modify variables at the top of this script to set file paths for:
>
> * Reference genome FASTA
> * Paired-end FASTQ files
> * GTF annotation file
> * HISAT2 index base name

---

### 2. `setup_environment.sh`

* Creates directories: `reference`, `fastq`, `GTF`
* Downloads the mouse reference genome annotation GTF file (Ensembl release 106)
* Installs **SRA Toolkit**
* Downloads SRA data (example: **SRR27700562**) using `prefetch`
* Converts SRA to gzipped FASTQ files using `fastq-dump`

---

## Usage

### Step 1: Setup environment and download data

```bash
bash setup_environment.sh
```

This will prepare your directory structure, download necessary genome annotations, and fetch SRA RNA-seq data.

---

### Step 2: Run RNA-seq analysis pipeline

Before running, **edit `rna_seq_analysis.sh`** to update file paths for your actual data and references.

Then run:

```bash
bash rna_seq_analysis.sh
```

---

## Requirements

* Linux environment with bash shell
* Tools installed and in PATH:

  * `fastqc`
  * `fastp`
  * `hisat2` and `hisat2-build`
  * `samtools`
  * `featureCounts` (from Subread package)
  * `wget`
  * `sra-toolkit`

---

## Notes

* Reference genome and annotation downloads are specific to mouse GRCm39 and Ensembl release 106. Update URLs for different versions or species if needed.
* The SRA accession used in the example is **SRR27700562**; replace with your own samples.
* Ensure you have sufficient disk space and permissions for downloads and indexing.
* This pipeline assumes **paired-end sequencing data**.

---

## Contact

For questions or help, please contact:
**Sarah Tolba** — [sarahtolba842@gmail.com](mailto:sarahtolba842@gmail.com)

---

