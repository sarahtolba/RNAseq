Overview
This repository contains a bash script pipeline for RNA-seq analysis of the paired-end Illumina HiSeq 2000 dataset GSM9009135 (SRX28948798). The dataset corresponds to Mus musculus and is part of a study investigating tumor-resident memory CD8+ T cells regulated by TGF-beta and IL-12.

Study Details
Sample ID: STCO_1-3_S32

External ID: GSM9009135_r1

Organism: Mus musculus (Mouse)

Instrument: Illumina HiSeq 2000

Run Type: Paired-end RNA-Seq

Total Reads: ~15.6 million spots (3.2 billion bases)

Data Size: Approx. 1 GB

Project: TGF-beta and IL-12 conversely orchestrate formation of CD103+ CD8 tumor-resident memory T cells to regulate response to therapeutic cancer vaccine

Project Accession: PRJNA1268430 / SRP588101

Sample Accession: SAMN48761962 / SRS25170976

Library Preparation Summary
Total RNA was extracted from sorted CD103+, CD49a+, and CD103negCD49aneg CD8 tumor-infiltrating lymphocyte (TIL) populations using a single-cell RNA purification kit (Norgen Biotek). RNA integrity was verified (RIN ≥ 7.0). Strand-specific libraries were prepared using the SureSelect Automated Strand-Specific RNA Library Preparation Kit. Fragmented mRNA was reverse-transcribed to cDNA, converted to double-stranded DNA, and sequenced paired-end on Illumina HiSeq 2000.

Pipeline Description
This bash script performs the following steps on the raw FASTQ paired-end reads:

Quality Check
Using fastqc on raw FASTQ files to assess initial quality.

Read Trimming
Using fastp to trim adapters and low-quality bases from both paired reads.

Reference Genome Indexing
Building the HISAT2 index from the Mus musculus GRCm39 reference genome.

Alignment
Aligning trimmed reads to the reference genome using HISAT2.

BAM Processing
Sorting and indexing aligned reads with samtools.

Quality Control of Alignment
Generating alignment statistics using samtools flagstat.

Gene-level Quantification
Counting mapped reads per gene using featureCounts with the appropriate GTF annotation.

Simple Count Matrix Extraction
Extracting gene ID and raw counts for downstream differential expression analysis.

Usage
Modify the paths to your data files and reference genome in the script variables (reference, read1, read2, GTF, etc.).

Ensure all required tools (fastqc, fastp, hisat2, samtools, featureCounts) are installed and accessible in your $PATH.

Run the bash script from the directory containing your data or adjust paths accordingly.

Outputs will be organized in directories:

fastqc_before/ : raw reads QC reports

fastq.tirmmed/ : trimmed FASTQ files

alignment/ : SAM, BAM files, alignment stats, and count files

Requirements
Linux environment (or WSL on Windows)

Installed bioinformatics tools:

fastqc

fastp

HISAT2

samtools

subread (for featureCounts)
