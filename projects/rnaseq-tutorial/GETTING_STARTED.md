# Getting Started with RNA-seq Analysis

Welcome to the RNA-seq Analysis Tutorial! This guide will help you get started quickly.

## Installation Steps
```bash
# 1. Clone the repository
git clone https://github.com/ipekselcen/rnaseq-tutorial.git
cd rnaseq-tutorial

# 2. Create conda environment
conda env create -f environment.yml

# 3. Activate environment
conda activate rnaseq

# 4. Verify installation
fastqc --version
STAR --version
Rscript --version
```


**R packages:**
```r
# Install BiocManager
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Install Bioconductor packages
BiocManager::install(c(
  "DESeq2",
  "clusterProfiler",
  "org.Mm.eg.db",
  "AnnotationDbi",
  "EnhancedVolcano",
  "ComplexHeatmap"))

# Install CRAN packages
install.packages(c(
  "ggplot2",
  "pheatmap",
  "RColorBrewer",
  "dplyr",
  "tidyr",
  "ggrepel"))
```

## Quick Start

### Run Complete Pipeline

```bash
# Download data and run entire analysis
bash scripts/run_pipeline.sh
```

This single command will:
1. Download RNA-seq data from GEO (GSE79018)
2. Perform quality control
3. Trim adapters
4. Align reads to genome
5. Count reads per gene
6. Run differential expression analysis
7. Perform pathway enrichment

**Expected runtime:** 4-6 hours (depending on your system)

### Run Step-by-Step

If you prefer to run steps individually:

```bash
# Step 1: Download data
bash scripts/01_download_data.sh

# Step 2: Quality control
bash scripts/02_quality_control.sh

# Step 3: Trim reads
bash scripts/03_trim_reads.sh

# Step 4: Align reads
bash scripts/04_align_reads.sh

# Step 5: Count reads
bash scripts/05_count_reads.sh

# Step 6: Differential expression
Rscript scripts/06_differential_expression.R

# Step 7: Pathway analysis
Rscript scripts/07_pathway_analysis.R
```

## What to Expect

### Data Requirements

The pipeline will download:
- **FASTQ files**: ~4 samples, ~20-40M reads each
- **Reference genome**: Mouse GRCm39
- **Gene annotation**: Ensembl GTF

### Output Files

After completion, you'll have:

```
results/
├── qc/                           # Quality control reports
│   └── raw_multiqc_report.html   # Open this in browser
├── aligned/                      # BAM files and alignment stats
├── counts/                       # Gene count matrix
├── deg/                          # Differential expression results
│   ├── deseq2_results_significant.csv
│   └── normalized_counts.csv
├── pathways/                     # Enrichment results
│   ├── GO_biological_process.csv
│   └── KEGG_pathways.csv
└── figures/                      # All plots
    ├── volcano_plot.png
    ├── pca_plot.png
    ├── heatmap_top_degs.png
    └── GO_BP_dotplot.png
```

## Viewing Results

### Quality Control Report

```bash
# Open MultiQC report in browser
open results/qc/raw/raw_multiqc_report.html  # macOS
```

### Differential Expression Results

```bash
# View in terminal
head results/deg/deseq2_results_significant.csv
```

### Figures

All publication-quality figures are in `results/figures/`:

```bash
# View figures
ls results/figures/

# View volcano plot
open results/figures/volcano_plot.png  # macOS
```

## Testing the Installation

Run this quick test to ensure everything is working:

```bash
# Test command-line tools
echo "Testing FastQC..."
fastqc --version

echo "Testing STAR..."
STAR --version

echo "Testing SAMtools..."
samtools --version

echo "Testing R..."
Rscript --version

# Test R packages
Rscript -e "library(DESeq2); library(clusterProfiler); cat('R packages OK\n')"
```

If all tests pass, you're ready to start!

---

**Ready to start?** Run `bash scripts/run_pipeline.sh` and grab some coffee! ☕

The analysis will take several hours, but you can monitor progress in the terminal.

Good luck with your RNA-seq analysis! 🧬
