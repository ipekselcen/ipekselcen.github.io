#!/bin/bash
# 05_count_reads.sh
# Counts reads per gene using featureCounts
# Usage: bash 05_count_reads.sh

set -e
set -u

echo "Starting Read Quantification"
echo ""

# Directories
ALIGN_DIR="results/aligned"
COUNT_DIR="results/counts"
REF_DIR="data/reference"
THREADS=16

# Create output directory
mkdir -p ${COUNT_DIR}

# Reference annotation
GTF="${REF_DIR}/Mus_musculus.GRCm39.115.gtf"

echo "Counting reads per gene with featureCounts..."

# Collect all BAM files
BAM_FILES=(${ALIGN_DIR}/*_Aligned.sortedByCoord.out.bam)

# Run featureCounts
featureCounts \
  -p \
  -B \
  -C \
  -T ${THREADS} \
  -a ${GTF} \
  -o ${COUNT_DIR}/gene_counts.txt \
  ${BAM_FILES[@]}

echo ""
echo "Processing count matrix..."

# Create clean count matrix with readable sample names
head -n 1 ${COUNT_DIR}/gene_counts.txt | \
  cut -f1,7- | \
  sed 's|results/aligned/||g' | \
  sed 's|_Aligned.sortedByCoord.out.bam||g' > ${COUNT_DIR}/count_matrix_clean.txt

tail -n +2 ${COUNT_DIR}/gene_counts.txt | \
  cut -f1,7- >> ${COUNT_DIR}/count_matrix_clean.txt

echo ""
echo "========================================"
echo "Read Counting Complete!"
echo "========================================"
echo ""
echo "Count matrix: ${COUNT_DIR}/count_matrix_clean.txt"
echo "Full output: ${COUNT_DIR}/gene_counts.txt"
echo ""
echo "Assignment Summary:"
cat ${COUNT_DIR}/gene_counts.txt.summary | column -t
echo ""
echo "Expected: >70% assigned reads"
echo ""
echo "Next step: Rscript scripts/06_differential_expression.R"
