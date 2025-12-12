#!/bin/bash

# 05_count_reads.sh
# Counts reads per gene using featureCounts from Subread package
# Usage: bash 05_count_reads.sh

set -e
set -u

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Starting Read Quantification${NC}"

# Directories
ALIGN_DIR="results/aligned"
COUNT_DIR="results/counts"
REF_DIR="data/reference"
THREADS=16

# Create output directory
mkdir -p ${COUNT_DIR}

# Reference annotation
GTF="${REF_DIR}/Homo_sapiens.GRCh38.110.gtf"

echo -e "${YELLOW}Step 1: Counting reads per gene with featureCounts${NC}"

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

echo -e "${GREEN}featureCounts complete${NC}"

echo -e "${YELLOW}Step 2: Processing count matrix${NC}"

# Extract count matrix (remove first 6 columns with gene info)
# Keep only gene_id and sample counts
cut -f1,7- ${COUNT_DIR}/gene_counts.txt | \
  sed '1d' > ${COUNT_DIR}/count_matrix.txt

# Create a clean count matrix with sample names
head -n 1 ${COUNT_DIR}/gene_counts.txt | \
  cut -f1,7- | \
  sed 's|results/aligned/||g' | \
  sed 's|_Aligned.sortedByCoord.out.bam||g' > ${COUNT_DIR}/count_matrix_clean.txt

tail -n +2 ${COUNT_DIR}/gene_counts.txt | \
  cut -f1,7- >> ${COUNT_DIR}/count_matrix_clean.txt

echo -e "${GREEN}Count matrix processed${NC}"

echo -e "${YELLOW}Step 3: Generating count statistics${NC}"

# Get assignment statistics from featureCounts summary
SUMMARY="${COUNT_DIR}/gene_counts.txt.summary"

echo "Sample Assignment Statistics:" > ${COUNT_DIR}/count_summary.txt
cat ${SUMMARY} >> ${COUNT_DIR}/count_summary.txt

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Read Counting Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Count matrix: ${COUNT_DIR}/count_matrix_clean.txt"
echo "Full featureCounts output: ${COUNT_DIR}/gene_counts.txt"
echo "Summary statistics: ${COUNT_DIR}/count_summary.txt"
echo ""
echo -e "${YELLOW}Assignment Summary:${NC}"
cat ${SUMMARY} | column -t
echo ""
echo -e "${YELLOW}Key metrics:${NC}"
echo "  - Assigned reads should be >70%"
echo "  - Unassigned_NoFeatures: reads not overlapping any gene"
echo "  - Unassigned_Ambiguity: reads overlapping multiple genes"
echo ""
echo -e "${YELLOW}Next step: Differential expression analysis in R${NC}"
echo "Rscript scripts/06_differential_expression.R"
