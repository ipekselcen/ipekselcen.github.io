#!/bin/bash
# 02_quality_control.sh
# Performs quality control on raw FASTQ files using FastQC and MultiQC
# Usage: bash 02_quality_control.sh

set -e
set -u

echo "Starting Quality Control Analysis"
echo ""

# Set directories
RAW_DIR="data/raw"
QC_DIR="results/qc/raw"
THREADS=8

# Create output directory
mkdir -p ${QC_DIR}

# Run FastQC on all FASTQ files
echo "Running FastQC on raw reads..."
fastqc \
  ${RAW_DIR}/*.fastq.gz \
  --outdir ${QC_DIR} \
  --threads ${THREADS} \
  --quiet

# Run MultiQC to aggregate all FastQC reports
echo "Generating MultiQC summary report..."
multiqc \
  ${QC_DIR} \
  --outdir ${QC_DIR} \
  --filename multiqc_report \
  --title "RNA-seq QC - Raw Reads" \
  --force

echo ""
echo "========================================"
echo "Quality Control Complete!"
echo "========================================"
echo ""
echo "View results:"
echo "  - MultiQC summary: ${QC_DIR}/multiqc_report.html"
echo "  - Individual FastQC: ${QC_DIR}/*_fastqc.html"
echo ""
echo "Key metrics to check:"
echo "  - Per base quality: should be >30"
echo "  - Adapter content: should be <5%"
echo "  - Duplication levels: normal for RNA-seq"
echo ""
echo "Next step: bash scripts/03_trim_reads.sh"
