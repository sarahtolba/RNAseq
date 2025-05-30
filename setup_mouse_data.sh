#!/bin/bash

# Step 1: Create directories
mkdir -p reference
mkdir -p fastq
mkdir -p GTF

# Step 2: Change to reference directory and download the genome fasta
cd reference
echo "Downloading Mus musculus genome reference (GRCm39, Ensembl)"
wget ftp://ftp.ensembl.org/pub/release-106/gtf/mus_musculus/Mus_musculus.GRCm39.106.gtf.gz

 #step3 : change to GTF directory and download it 
cd ../GTF
echo "Downloading Mus musculus genome GTF file"
wget ftp://ftp.ensembl.org/pub/release-106/gtf/homo_sapiens/Homo_sapiens.GRCh38.106.gtf.gz
 
# Step 4: Go back and change to fastq directory
cd ../fastq

# Step 5: Install SRA Toolkit
echo "Updating system and installing SRA Toolkit..."
sudo apt update
sudo apt install -y sra-toolkit


# Step 6: Download SRA data using prefetch
echo "Downloading SRA file SRR27700562..."
prefetch SRR27700562

# Step 7: Convert SRA to gzipped FASTQ
echo "Converting SRA to gzipped FASTQ..."
fastq-dump --split-files --gzip ~/ncbi/public/sra/SRR27700562.sra

echo "All steps completed."
