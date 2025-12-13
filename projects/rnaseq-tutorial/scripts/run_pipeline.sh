#!/bin/bash

# run_pipeline.sh
# Master script to run complete RNA-seq analysis pipeline
# Usage: bash run_pipeline.sh [skip-download]

set -e
set -u

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  RNA-seq Analysis Pipeline${NC}"
echo -e "${BLUE}  Complete End-to-End Workflow${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if skip download option is provided
SKIP_DOWNLOAD=false
if [ $# -gt 0 ] && [ "$1" == "skip-download" ]; then
  SKIP_DOWNLOAD=true
  echo -e "${YELLOW}Skipping data download step${NC}"
fi

# Record start time
START_TIME=$(date +%s)

# ============================================================================
# Step 1: Download Data
# ============================================================================
if [ "$SKIP_DOWNLOAD" = false ]; then
  echo -e "\n${GREEN}[1/7] Downloading data from GEO...${NC}"
  bash scripts/01_download_data.sh
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Data download complete${NC}"
  else
    echo -e "${RED}✗ Data download failed${NC}"
    exit 1
  fi
else
  echo -e "\n${YELLOW}[1/7] Skipping data download${NC}"
fi

# ============================================================================
# Step 2: Quality Control
# ============================================================================
echo -e "\n${GREEN}[2/7] Running quality control...${NC}"
bash scripts/02_quality_control.sh
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Quality control complete${NC}"
else
  echo -e "${RED}✗ Quality control failed${NC}"
  exit 1
fi

# ============================================================================
# Step 3: Read Trimming
# ============================================================================
echo -e "\n${GREEN}[3/7] Trimming adapters and low-quality bases...${NC}"
bash scripts/03_trim_reads.sh
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Read trimming complete${NC}"
else
  echo -e "${RED}✗ Read trimming failed${NC}"
  exit 1
fi

# ============================================================================
# Step 4: Genome Alignment
# ============================================================================
echo -e "\n${GREEN}[4/7] Aligning reads to reference genome...${NC}"
bash scripts/04_align_reads.sh
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Genome alignment complete${NC}"
else
  echo -e "${RED}✗ Genome alignment failed${NC}"
  exit 1
fi

# ============================================================================
# Step 5: Read Quantification
# ============================================================================
echo -e "\n${GREEN}[5/7] Counting reads per gene...${NC}"
bash scripts/05_count_reads.sh
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Read quantification complete${NC}"
else
  echo -e "${RED}✗ Read quantification failed${NC}"
  exit 1
fi

# ============================================================================
# Step 6: Differential Expression Analysis
# ============================================================================
echo -e "\n${GREEN}[6/7] Performing differential expression analysis...${NC}"
Rscript scripts/06_differential_expression.R
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Differential expression analysis complete${NC}"
else
  echo -e "${RED}✗ Differential expression analysis failed${NC}"
  exit 1
fi

# ============================================================================
# Step 7: Pathway Analysis
# ============================================================================
echo -e "\n${GREEN}[7/7] Running functional enrichment analysis...${NC}"
Rscript scripts/07_pathway_analysis.R
if [ $? -eq 0 ]; then
  echo -e "${GREEN}✓ Pathway analysis complete${NC}"
else
  echo -e "${RED}✗ Pathway analysis failed${NC}"
  exit 1
fi

# ============================================================================
# Generate Final Report
# ============================================================================
echo -e "\n${BLUE}Generating analysis summary...${NC}"

REPORT_FILE="results/analysis_summary.txt"

cat > ${REPORT_FILE} << EOF
========================================
RNA-seq Analysis Summary
========================================
Analysis Date: $(date)

Dataset: GSE79018
Organism: Mus musculus
Design: Treatment vs Control

PIPELINE STEPS COMPLETED:
1. ✓ Data download and quality control
2. ✓ Adapter trimming
3. ✓ Genome alignment (STAR)
4. ✓ Read quantification (featureCounts)
5. ✓ Differential expression (DESeq2)
6. ✓ Pathway analysis (clusterProfiler)

RESULTS DIRECTORIES:
- QC Reports: results/qc/
- Alignment: results/aligned/
- Counts: results/counts/
- DEGs: results/deg/
- Pathways: results/pathways/
- Figures: results/figures/

KEY FILES:
- DEG Results: results/deg/deseq2_results_significant.csv
- Normalized Counts: results/deg/normalized_counts.csv
- GO Enrichment: results/pathways/GO_biological_process.csv
- KEGG Pathways: results/pathways/KEGG_pathways.csv

FIGURES GENERATED:
- PCA Plot: results/figures/pca_plot.png
- Volcano Plot: results/figures/volcano_plot.png
- MA Plot: results/figures/ma_plot.png
- Heatmap: results/figures/heatmap_top_degs.png
- GO Enrichment: results/figures/GO_BP_dotplot.png
- KEGG Pathways: results/figures/KEGG_dotplot.png

========================================
EOF

cat ${REPORT_FILE}

# Calculate total runtime
END_TIME=$(date +%s)
RUNTIME=$((END_TIME - START_TIME))
HOURS=$((RUNTIME / 3600))
MINUTES=$(((RUNTIME % 3600) / 60))
SECONDS=$((RUNTIME % 60))

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Pipeline Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "Total runtime: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo ""
echo -e "${YELLOW}To view results:${NC}"
echo "  - Open MultiQC report: results/qc/raw/raw_multiqc_report.html"
echo "  - Check DEG results: results/deg/deseq2_results_significant.csv"
echo "  - View figures: results/figures/"
echo ""
echo -e "${GREEN}Analysis summary saved to: ${REPORT_FILE}${NC}"
