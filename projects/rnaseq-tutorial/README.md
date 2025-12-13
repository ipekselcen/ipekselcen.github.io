# RNA-seq Analysis Tutorial: From Raw Reads to Biological Insight

[![Language](https://img.shields.io/badge/Language-R%20%7C%20Bash-blue)](https://www.r-project.org/)
[![Status](https://img.shields.io/badge/Status-Complete-success)](https://github.com/ipekselcen/rnaseq-tutorial)

A comprehensive, reproducible RNA-seq analysis workflow using public data from GEO (GSE79018).

## Overview

This tutorial provides an end-to-end RNA-seq analysis pipeline covering:
- Quality control and read trimming
- Reference genome alignment
- Gene expression quantification
- Differential expression analysis
- Functional enrichment analysis
- Data visualization

**Estimated time:** 4-6 hours  
**Skill level:** Beginner to Intermediate

## Dataset Information

**GEO Accession:** GSE79018  
**Organism:** *Mus musculus* (Mouse)  
**Sequencing:** Illumina paired-end RNA-seq  
**Study Design:** Control vs Treatment comparison  

## Prerequisites

### Required Software
- R (≥4.0)
- FastQC (≥0.11.9)
- Trim Galore (≥0.6.7)
- STAR (≥2.7.0)
- SAMtools (≥1.15)
- featureCounts (Subread package)

### R Packages
```r
# Bioconductor packages
BiocManager::install(c("DESeq2", "clusterProfiler", "org.Mm.eg.db", 
                       "AnnotationDbi", "EnhancedVolcano", "ComplexHeatmap"))

# CRAN packages
install.packages(c("ggplot2", "pheatmap", "RColorBrewer", "dplyr",
                    "tidyr", "ggrepel"))
```

## Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/ipekselcen/rnaseq-tutorial.git
cd rnaseq-tutorial
```

### 2. Set Up Environment
```bash
# Create conda environment
conda env create -f environment.yml
conda activate rnaseq
```

### 3. Download Data
```bash
# Download from GEO
bash scripts/01_download_data.sh
```

### 4. Run Complete Pipeline
```bash
# Process all samples
bash scripts/run_pipeline.sh

# Or run step-by-step (see below)
```

## Step-by-Step Workflow

### Step 1: Quality Control
```bash
bash scripts/02_quality_control.sh
```
- Assesses raw read quality with FastQC
- Generates MultiQC report

### Step 2: Read Trimming
```bash
bash scripts/03_trim_reads.sh
```
- Removes adapters and low-quality bases
- Performs quality control on trimmed reads

### Step 3: Genome Alignment
```bash
bash scripts/04_align_reads.sh
```
- Aligns reads to reference genome using STAR
- Generates BAM files and alignment statistics

### Step 4: Read Quantification
```bash
bash scripts/05_count_reads.sh
```
- Counts reads per gene using featureCounts
- Produces count matrix

### Step 5: Differential Expression Analysis
```r
# In R
source("scripts/06_differential_expression.R")
```
- Normalizes count data with DESeq2
- Identifies differentially expressed genes
- Generates MA plots, volcano plots

### Step 6: Functional Enrichment
```r
source("scripts/07_pathway_analysis.R")
```
- Gene Ontology (GO) enrichment
- KEGG pathway analysis
- Visualization of enriched pathways

## Project Structure

```
rnaseq-tutorial/
├── README.md                      # This file
├── environment.yml                # Conda environment
├── data/
│   ├── raw/                       # Raw FASTQ files
│   ├── reference/                 # Genome and annotation
│   └── metadata.csv               # Sample information
├── scripts/
│   ├── 01_download_data.sh        # Download from GEO
│   ├── 02_quality_control.sh      # FastQC
│   ├── 03_trim_reads.sh           # Trim Galore
│   ├── 04_align_reads.sh          # STAR alignment
│   ├── 05_count_reads.sh          # featureCounts
│   ├── 06_differential_expression.R  # DESeq2 analysis
│   ├── 07_pathway_analysis.R      # Enrichment analysis
│   └── run_pipeline.sh            # Run all steps
├── notebooks/
│   └── RNA-seq_analysis.Rmd       # Complete R Markdown notebook
├── results/
│   ├── qc/                        # Quality control reports
│   ├── counts/                    # Count matrices
│   ├── deg/                       # Differential expression results
│   └── figures/                   # Publication-ready figures
└── docs/
    └── tutorial.md                # Detailed tutorial with explanations
```

## Key Results

After running the pipeline, you will generate:

1. **Quality Control Reports**
   - MultiQC summary of all samples
   - Per-sample FastQC reports

2. **Alignment Statistics**
   - Mapping rates
   - Uniquely mapped reads
   - Multimapping reads

3. **Differential Expression Results**
   - Table of DEGs (FDR < 0.05, |log2FC| > 1)
   - Volcano plot
   - MA plot
   - PCA plot

4. **Functional Enrichment**
   - GO terms (Biological Process, Molecular Function, Cellular Component)
   - KEGG pathways
   - Enrichment dotplots and bar plots

## Expected Output

### Sample Counts
- Total reads per sample: ~20-40 million
- Mapping rate: >85%
- Assigned reads: >70%

### Differential Expression
- Upregulated genes: ~XXX
- Downregulated genes: ~XXX
- Total DEGs (FDR<0.05): ~XXX


### R Package Installation
```r
# If BiocManager installation fails
options(BioC_mirror = "https://bioconductor.org")
BiocManager::install(version = "3.18")
```

## Data Availability
- **GEO Accession:** [GSE79018](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE79018)
- **Reference Genome:** GRCm39 (Ensembl)
- **Gene Annotation:** gencode.vM38.annotation.gtf

### Learn More
- [DESeq2 Vignette](http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html)
- [RNA-seqlopedia](https://rnaseq.uoregon.edu/)
- [STAR Manual](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)


## Acknowledgments

- Data from GEO (GSE79018)
- Bioconductor and R community
- STAR, DESeq2, and clusterProfiler developers
