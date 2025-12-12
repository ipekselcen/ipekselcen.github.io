#!/bin/bash

# 03_trim_reads.sh
# Trims adapters and low-quality bases using Trim Galore
# Usage: bash 03_trim_reads.sh

set -e
set -u

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Starting Read Trimming${NC}"

# Directories
RAW_DIR="data/raw"
TRIMMED_DIR="data/trimmed"
QC_DIR="results/qc/trimmed"
THREADS=8

# Create output directories
mkdir -p ${TRIMMED_DIR}
mkdir -p ${QC_DIR}

echo -e "${YELLOW}Step 1: Trimming reads with Trim Galore${NC}"

# Read metadata and process each sample
while IFS=',' read -r sample_id sra_id condition replicate fastq_1 fastq_2; do
  # Skip header
  if [ "$sample_id" == "sample_id" ]; then
    continue
  fi
  
  echo -e "${GREEN}Processing ${sample_id}...${NC}"
  
  # Check if already trimmed
  if [ -f "${TRIMMED_DIR}/${sra_id}_1_val_1.fq.gz" ]; then
    echo -e "${YELLOW}${sample_id} already trimmed, skipping...${NC}"
    continue
  fi
  
  # Run Trim Galore
  trim_galore \
    --paired \
    --fastqc \
    --quality 20 \
    --length 36 \
    --cores ${THREADS} \
    --output_dir ${TRIMMED_DIR} \
    ${fastq_1} ${fastq_2}
    
  echo -e "${GREEN}${sample_id} trimmed successfully${NC}"
  
done < data/metadata.csv

echo -e "${YELLOW}Step 2: Running FastQC on trimmed reads${NC}"

# Run FastQC on trimmed files (if not already done by Trim Galore)
fastqc \
  ${TRIMMED_DIR}/*_val_*.fq.gz \
  --outdir ${QC_DIR} \
  --threads ${THREADS} \
  --quiet

echo -e "${YELLOW}Step 3: Generating MultiQC report for trimmed reads${NC}"

# Run MultiQC
multiqc \
  ${QC_DIR} \
  ${TRIMMED_DIR} \
  --outdir ${QC_DIR} \
  --filename trimmed_multiqc_report \
  --title "RNA-seq QC - Trimmed Reads" \
  --force

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Trimming Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Trimmed files: ${TRIMMED_DIR}/*_val_*.fq.gz"
echo "QC reports: ${QC_DIR}/trimmed_multiqc_report.html"
echo ""
echo -e "${YELLOW}Trimming statistics:${NC}"
grep "Total reads processed:" ${TRIMMED_DIR}/*.txt | head -n 3
echo ""
echo -e "${YELLOW}Next step: Align reads to reference genome${NC}"
echo "bash scripts/04_align_reads.sh"
