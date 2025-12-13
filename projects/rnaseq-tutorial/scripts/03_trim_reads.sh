#!/bin/bash
# 03_trim_reads.sh
# Trims adapters and low-quality bases using Trim Galore
# Usage: bash 03_trim_reads.sh

set -e
set -u

echo "Starting Read Trimming"
echo ""

# Directories
RAW_DIR="data/raw"
TRIMMED_DIR="data/trimmed"
QC_DIR="results/qc/trimmed"
THREADS=8

# Create output directories
mkdir -p ${TRIMMED_DIR}
mkdir -p ${QC_DIR}

# Process each sample from metadata
echo "Trimming reads with Trim Galore..."

while IFS=',' read -r sample_id sra_id condition replicate fastq_1 fastq_2; do
  
  # Skip header line
  if [ "$sample_id" == "sample_id" ]; then
    continue
  fi
  
  echo "  Processing ${sample_id}..."
  
  # Skip if already trimmed
  if [ -f "${TRIMMED_DIR}/${sra_id}_1_val_1.fq.gz" ]; then
    echo "    Already trimmed, skipping"
    continue
  fi
  
  # Trim adapters and low-quality bases
  trim_galore \
    --paired \
    --fastqc \
    --quality 20 \
    --length 36 \
    --cores ${THREADS} \
    --output_dir ${TRIMMED_DIR} \
    ${fastq_1} ${fastq_2}
    
done < data/metadata.csv

echo ""
echo "Generating MultiQC report..."

# Aggregate QC reports
multiqc \
  ${QC_DIR} \
  ${TRIMMED_DIR} \
  --outdir ${QC_DIR} \
  --filename trimmed_multiqc_report \
  --title "RNA-seq QC - Trimmed Reads" \
  --force

echo ""
echo "========================================"
echo "Trimming Complete!"
echo "========================================"
echo ""
echo "Trimmed files: ${TRIMMED_DIR}/*_val_*.fq.gz"
echo "QC report: ${QC_DIR}/trimmed_multiqc_report.html"
echo ""
echo "Next step: bash scripts/04_align_reads.sh"
