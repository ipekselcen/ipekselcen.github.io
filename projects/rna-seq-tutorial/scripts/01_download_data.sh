#!/bin/bash

# 01_download_data.sh
# Downloads RNA-seq data from GEO accession GSE79018
# Usage: bash 01_download_data.sh

set -e  # Exit on error
set -u  # Exit on undefined variable

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting data download for GSE79018${NC}"

# Create directories
mkdir -p data/raw
mkdir -p data/reference
mkdir -p results/qc

# Set GEO accession
GEO_ACC="GSE79018"

echo -e "${YELLOW}Step 1: Fetching sample information from GEO${NC}"

# Download SRA Run Info
wget -O data/SraRunTable.txt \
  "https://www.ncbi.nlm.nih.gov/Traces/study/?acc=${GEO_ACC}&o=acc_s%3Aa" || \
  echo "Note: Direct download failed. Please manually download SRA Run Table from GEO."

# Parse SRA accessions (example - adjust based on actual data)
# For this tutorial, we'll use a subset of samples
# In practice, you would parse the SRA Run Table

# Example SRA accessions (replace with actual accessions from GSE79018)
SRA_IDS=(
  "SRR3212794"
  "SRR3212795"
  "SRR3212796"
  "SRR3212797"
)

echo -e "${YELLOW}Step 2: Downloading FASTQ files from SRA${NC}"

# Download FASTQ files using fastq-dump or fasterq-dump
for SRA_ID in "${SRA_IDS[@]}"; do
  echo -e "${GREEN}Downloading ${SRA_ID}...${NC}"
  
  # Check if files already exist
  if [ -f "data/raw/${SRA_ID}_1.fastq.gz" ] && [ -f "data/raw/${SRA_ID}_2.fastq.gz" ]; then
    echo -e "${YELLOW}${SRA_ID} already downloaded, skipping...${NC}"
    continue
  fi
  
  # Download using parallel-fastq-dump (faster)
  parallel-fastq-dump \
    --sra-id ${SRA_ID} \
    --threads 4 \
    --outdir data/raw \
    --split-files \
    --gzip
    
  echo -e "${GREEN}${SRA_ID} downloaded successfully${NC}"
done

echo -e "${YELLOW}Step 3: Downloading reference genome and annotation${NC}"

# Download human reference genome (GRCh38)
cd data/reference

# Download genome FASTA
if [ ! -f "Mus_musculus.GRCm39.dna.primary_assembly.fa.gz" ]; then
  echo "Downloading reference genome..."
  wget https://ftp.ensembl.org/pub/release-110/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
  gunzip Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
else
  echo "Reference genome already exists"
fi

# Download GTF annotation
if [ ! -f "Mus_musculus.GRCm39.115.gtf.gz" ]; then
  echo "Downloading gene annotation..."
  wget https://ftp.ensembl.org/pub/release-110/gtf/mus_musculus/Mus_musculus.GRCm39.115.gtf.gz
  gunzip Mus_musculus.GRCm39.115.gtf.gz
else
  echo "Gene annotation already exists"
fi

cd ../..

echo -e "${YELLOW}Step 4: Creating metadata file${NC}"

# Create sample metadata CSV
cat > data/metadata.csv << 'EOF'
sample_id,sra_id,condition,replicate,fastq_1,fastq_2
Control_1,SRR3212794,Control,1,data/raw/SRR3212794_1.fastq.gz,data/raw/SRR3212794_2.fastq.gz
Control_2,SRR3212795,Control,2,data/raw/SRR3212795_1.fastq.gz,data/raw/SRR3212795_2.fastq.gz
Treatment_1,SRR3212796,Treatment,1,data/raw/SRR3212796_1.fastq.gz,data/raw/SRR3212796_2.fastq.gz
Treatment_2,SRR3212797,Treatment,2,data/raw/SRR3212797_1.fastq.gz,data/raw/SRR3212797_2.fastq.gz
EOF

echo -e "${GREEN}Metadata file created: data/metadata.csv${NC}"

# Summary
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Data download complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Downloaded files:"
ls -lh data/raw/*.fastq.gz 2>/dev/null || echo "FASTQ files will be in data/raw/"
echo ""
echo "Reference files:"
ls -lh data/reference/ 2>/dev/null || echo "Reference files will be in data/reference/"
echo ""
echo -e "${YELLOW}Next step: Run quality control${NC}"
echo "bash scripts/02_quality_control.sh"
