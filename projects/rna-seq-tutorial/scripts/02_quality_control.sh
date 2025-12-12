#!/bin/bash

# 02_quality_control.sh
# Performs quality control on raw FASTQ files using FastQC and MultiQC
# Usage: bash 02_quality_control.sh

set -e
set -u

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Starting Quality Control Analysis${NC}"

# Set directories
RAW_DIR="data/raw"
QC_DIR="results/qc/raw"
THREADS=8

# Create output directory
mkdir -p ${QC_DIR}

echo -e "${YELLOW}Step 1: Running FastQC on raw reads${NC}"

# Run FastQC on all FASTQ files
fastqc \
  ${RAW_DIR}/*.fastq.gz \
  --outdir ${QC_DIR} \
  --threads ${THREADS} \
  --quiet

echo -e "${GREEN}FastQC complete${NC}"

echo -e "${YELLOW}Step 2: Generating MultiQC report${NC}"

# Run MultiQC to aggregate all FastQC reports
multiqc \
  ${QC_DIR} \
  --outdir ${QC_DIR} \
  --filename raw_multiqc_report \
  --title "RNA-seq QC - Raw Reads" \
  --force

echo -e "${GREEN}MultiQC report generated${NC}"

# Generate summary statistics
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Quality Control Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Reports generated:"
echo "  - Individual FastQC reports: ${QC_DIR}/*_fastqc.html"
echo "  - MultiQC summary: ${QC_DIR}/raw_multiqc_report.html"
echo ""
echo -e "${YELLOW}Key metrics to check:${NC}"
echo "  1. Per base sequence quality (should be >30)"
echo "  2. Per sequence quality scores (peak should be >30)"
echo "  3. Adapter content (should be minimal)"
echo "  4. Sequence duplication levels"
echo "  5. Overrepresented sequences"
echo ""
echo -e "${YELLOW}Next step: Trim adapters and low-quality bases${NC}"
echo "bash scripts/03_trim_reads.sh"
