#!/bin/bash

# Step 1: Create directories
mkdir -p reference
mkdir -p fastq

# Step 2: Change to reference directory and download the genome fasta
cd reference
echo "Downloading Mus musculus genome reference (GRCm39, Ensembl)"
wget ftp://ftp.ensembl.org/pub/release-111/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz

# Step 3: Go back and change to fastq directory
cd ../fastq

# Step 4: Install SRA Toolkit
echo "Updating system and installing SRA Toolkit..."
sudo apt update
sudo apt install -y sra-toolkit


# Step 5: Download SRA data using prefetch
echo "Downloading SRA file SRR27700562..."
prefetch SRR27700562

# Step 6: Convert SRA to gzipped FASTQ
echo "Converting SRA to gzipped FASTQ..."
fastq-dump --split-files --gzip ~/ncbi/public/sra/SRR27700562.sra

echo "All steps completed."
