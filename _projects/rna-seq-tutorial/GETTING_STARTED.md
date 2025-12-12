# Getting Started with RNA-seq Analysis

Welcome to the RNA-seq Analysis Tutorial! This guide will help you get started quickly.

## Prerequisites Checklist

Before starting, ensure you have:

- [ ] Linux/Unix system or WSL2 on Windows
- [ ] At least 32 GB RAM (recommended 64 GB for human genome)
- [ ] At least 100 GB free disk space
- [ ] Internet connection for downloading data

## Installation Steps

### Option 1: Using Conda (Recommended)

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

### Option 2: Manual Installation

If you prefer manual installation, install these tools:

**Command-line tools:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install fastqc trimmomatic samtools

# Install STAR from source
wget https://github.com/alexdobin/STAR/archive/2.7.11a.tar.gz
tar -xzf 2.7.11a.tar.gz
cd STAR-2.7.11a/source
make STAR
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
  "org.Hs.eg.db",
  "AnnotationDbi",
  "EnhancedVolcano",
  "ComplexHeatmap"
))

# Install CRAN packages
install.packages(c(
  "ggplot2",
  "pheatmap",
  "RColorBrewer",
  "dplyr",
  "tidyr",
  "ggrepel"
))
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
- **FASTQ files**: ~6 samples, ~20-40M reads each (~6-12 GB total)
- **Reference genome**: Human GRCh38 (~3 GB)
- **Gene annotation**: Ensembl GTF (~50 MB)

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
firefox results/qc/raw/raw_multiqc_report.html
# or
open results/qc/raw/raw_multiqc_report.html  # macOS
```

### Differential Expression Results

```bash
# View in terminal
head results/deg/deseq2_results_significant.csv

# Or open in Excel/LibreOffice
libreoffice results/deg/deseq2_results_significant.csv
```

### Figures

All publication-quality figures are in `results/figures/`:

```bash
# View figures
ls results/figures/

# Example: View volcano plot
eog results/figures/volcano_plot.png  # Linux
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

## Common Issues

### Issue: "Command not found"

**Solution:** Make sure the conda environment is activated:
```bash
conda activate rnaseq
```

### Issue: "Permission denied" when running scripts

**Solution:** Make scripts executable:
```bash
chmod +x scripts/*.sh
```

### Issue: Out of memory during STAR alignment

**Solution:** Reduce memory usage or process one sample at a time:
```bash
# Edit scripts/04_align_reads.sh
# Add: --limitBAMsortRAM 30000000000
```

### Issue: R packages fail to install

**Solution:** Try installing from source:
```r
install.packages("package_name", type = "source")
```

## Getting Help

- **Tutorial website:** [https://ipekselcen.github.io/projects/rnaseq-tutorial/](https://ipekselcen.github.io/projects/rnaseq-tutorial/)
- **GitHub Issues:** [https://github.com/ipekselcen/rnaseq-tutorial/issues](https://github.com/ipekselcen/rnaseq-tutorial/issues)
- **Email:** ipek.selcen@gmail.com

## Next Steps

After completing this tutorial, you can:

1. **Modify parameters** - Try different thresholds for DEGs
2. **Use your own data** - Replace GSE79018 with your dataset
3. **Explore advanced analyses** - Alternative splicing, fusion detection
4. **Try related tutorials** - ATAC-seq, ChIP-seq, multi-omics integration

## Citation

If you use this tutorial in your research, please cite:

```
Selcen, I. (2025). RNA-seq Analysis Tutorial: From Raw Reads to Biological Insight.
GitHub: https://github.com/ipekselcen/rnaseq-tutorial
```

---

**Ready to start?** Run `bash scripts/run_pipeline.sh` and grab some coffee! ☕

The analysis will take several hours, but you can monitor progress in the terminal.

Good luck with your RNA-seq analysis! 🧬
