#!/bin/bash

# run_pipeline.sh
# Master script to run complete RNA-seq analysis pipeline
# Usage: bash run_pipeline.sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "========================================"
echo "  RNA-seq Analysis Pipeline"
echo "  Complete End-to-End Workflow"
echo "========================================"
echo ""

# Record start time
START_TIME=$(date +%s)

# Step 1: Download Data
echo ""
echo "[1/7] Downloading data from GEO..."
bash scripts/01_download_data.sh

# Step 2: Quality Control
echo ""
echo "[2/7] Running quality control..."
bash scripts/02_quality_control.sh

# Step 3: Read Trimming
echo ""
echo "[3/7] Trimming adapters and low-quality bases..."
bash scripts/03_trim_reads.sh

# Step 4: Genome Alignment
echo ""
echo "[4/7] Aligning reads to reference genome..."
bash scripts/04_align_reads.sh

# Step 5: Read Quantification
echo ""
echo "[5/7] Counting reads per gene..."
bash scripts/05_count_reads.sh

# Step 6: Differential Expression Analysis
echo ""
echo "[6/7] Performing differential expression analysis..."
Rscript scripts/06_differential_expression.R

# Step 7: Pathway Analysis
echo ""
echo "[7/7] Running functional enrichment analysis..."
Rscript scripts/07_pathway_analysis.R

# Generate summary report
echo ""
echo "Generating analysis summary..."

cat > results/analysis_summary.txt << EOF
========================================
RNA-seq Analysis Summary
========================================
Analysis Date: $(date)

Dataset: GSE79018 (Moyon et al. 2016)
Organism: Mus musculus (Mouse)
Design: Dnmt1 KO vs Control (2 replicates each)

PIPELINE STEPS COMPLETED:
1. Data download and quality control
2. Adapter trimming
3. Genome alignment (STAR)
4. Read quantification (featureCounts)
5. Differential expression (DESeq2)
6. Pathway analysis (clusterProfiler)

RESULTS DIRECTORIES:
- QC Reports: results/qc/
- Alignment: results/aligned/
- Counts: results/counts/
- DEGs: results/deg/
- Pathways: results/pathways/
- Figures: results/figures/

KEY OUTPUT FILES:
- DEG Results: results/deg/deseq2_results_significant.csv
- Normalized Counts: results/deg/normalized_counts.csv
- GO Enrichment: results/pathways/GO_biological_process.csv
- KEGG Pathways: results/pathways/KEGG_pathways.csv

FIGURES (300 DPI PNG):
- PCA Plot: results/figures/pca_plot.png
- Volcano Plot: results/figures/volcano_plot.png
- MA Plot: results/figures/ma_plot.png
- Heatmap: results/figures/heatmap_top_degs.png
- GO Enrichment: results/figures/GO_BP_dotplot.png
- KEGG Pathways: results/figures/KEGG_dotplot.png

========================================
EOF

cat results/analysis_summary.txt

# Calculate runtime
END_TIME=$(date +%s)
RUNTIME=$((END_TIME - START_TIME))
HOURS=$((RUNTIME / 3600))
MINUTES=$(((RUNTIME % 3600) / 60))
SECONDS=$((RUNTIME % 60))

echo ""
echo "========================================"
echo "Pipeline Complete!"
echo "========================================"
echo ""
echo "Total runtime: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo ""
echo "To view results:"
echo "  - MultiQC report: results/qc/multiqc_report.html"
echo "  - DEG results: results/deg/deseq2_results_significant.csv"
echo "  - Figures: results/figures/"
echo ""
