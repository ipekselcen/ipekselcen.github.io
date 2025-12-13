---
layout: default
title: "RNA-seq Analysis Tutorial"
permalink: /projects/rnaseq-tutorial/
---

<div class="project-header">
  <h1>RNA-seq Analysis Tutorial</h1>
  <p class="lead">A comprehensive, reproducible workflow from raw reads to biological insights</p>
  
  <div class="badges">
    <span class="badge badge-primary">R</span>
    <span class="badge badge-primary">Bash</span>
    <span class="badge badge-success">Complete</span>
    <span class="badge badge-info">4-6 hours</span>
  </div>

---

## Overview

This tutorial provides a complete, reproducible RNA-seq analysis pipeline using public data from the Gene Expression Omnibus (GEO). You'll learn how to:

- **Process** raw sequencing reads from quality control to alignment
- **Analyze** gene expression data to identify differentially expressed genes
- **Interpret** results through functional enrichment analysis
- **Visualize** data with publication-quality figures

**Dataset:** [GSE79018](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE79018) - Mouse RNA-seq comparing *Dnmt1*-cKO vs control conditions in OPCs

---

## What You'll Learn

### Bioinformatics Skills
- Quality control with FastQC and MultiQC
- Read trimming and adapter removal
- Genome alignment with STAR
- Read quantification with featureCounts
- Statistical analysis with DESeq2
- Pathway enrichment with clusterProfiler

### Best Practices
- Reproducible analysis workflows
- Version control with Git
- Environment management with Conda
- Publication-ready visualizations
- Result interpretation

---

## Tutorial Structure

<div class="tutorial-steps">

### 1. Data Acquisition
**Time:** ~30 minutes  
Download RNA-seq data from GEO and prepare reference genome

```bash
bash scripts/01_download_data.sh
```

**What you'll learn:** SRA data retrieval, reference genome setup

---

### 2. Quality Control
**Time:** ~20 minutes  
Assess raw read quality and identify potential issues

```bash
bash scripts/02_quality_control.sh
```

**Output:** MultiQC report, per-sample FastQC reports

**Key metrics:**
- Per-base sequence quality (should be >30)
- Adapter content (should be minimal)
- Sequence duplication levels
- GC content distribution

---

### 3. Read Trimming
**Time:** ~40 minutes  
Remove adapters and low-quality bases

```bash
bash scripts/03_trim_reads.sh
```

**Tool:** Trim Galore (wrapper for Cutadapt + FastQC)

**Parameters:**
- Quality threshold: 20
- Minimum length: 36 bp
- Automatically detects Illumina adapters

---

### 4. Genome Alignment
**Time:** ~2 hours  
Align reads to reference genome using STAR

```bash
bash scripts/04_align_reads.sh
```

**Why STAR?**
- Fast alignment for RNA-seq
- Accurate splice junction detection
- Widely used in RNA-seq studies

**Expected results:**
- Uniquely mapped reads: >80%
- Unmapped reads: <10%

---

### 5. Read Quantification
**Time:** ~20 minutes  
Count reads mapping to each gene

```bash
bash scripts/05_count_reads.sh
```

**Tool:** featureCounts

**Output:** Count matrix (genes × samples)

---

### 6. Differential Expression
**Time:** ~15 minutes  
Identify genes with significant expression changes

```r
Rscript scripts/06_differential_expression.R
```

**Method:** DESeq2

**Thresholds:**
- Adjusted p-value (FDR): < 0.05
- Log2 fold change: > 1 or < -1

**Visualizations:**
- PCA plot
- Sample correlation heatmap
- MA plot
- Volcano plot
- Heatmap of top DEGs

---

### 7. Functional Enrichment
**Time:** ~20 minutes  
Understand biological meaning of gene expression changes

```r
Rscript scripts/07_pathway_analysis.R
```

**Analyses:**
- Gene Ontology (GO) enrichment
- KEGG pathway analysis
- Gene Set Enrichment Analysis (GSEA)

</div>

---

## Quick Start

### Prerequisites

**Software:**
```bash
# Required tools
- FastQC (≥0.11.9)
- Trim Galore (≥0.6.7)
- STAR (≥2.7.0)
- SAMtools (≥1.15)
- Subread (featureCounts)
- R (≥4.0)
```

**R Packages:**
```r
# Install Bioconductor packages
BiocManager::install(c(
  "DESeq2", 
  "clusterProfiler",
  "org.Mm.eg.db",
  "EnhancedVolcano",
  "ComplexHeatmap"
))

# Install CRAN packages
install.packages(c(
  "ggplot2",
  "pheatmap",
  "dplyr",
  "ggrepel"
))
```

### Installation

```bash
# Clone repository
git clone https://github.com/ipekselcen/rnaseq-tutorial.git
cd rnaseq-tutorial

# Create conda environment (recommended)
conda env create -f environment.yml
conda activate rnaseq

# Run complete pipeline
bash scripts/run_pipeline.sh
```

---

## Example Results

### Differential Expression

<div class="results-gallery">
  <div class="result-item">
    <img src="results/figures/volcano_plot.png" alt="Volcano Plot">
    <p><strong>Volcano Plot</strong> - Shows magnitude and significance of gene expression changes</p>
  </div>
  
  <div class="result-item">
    <img src="results/figures/heatmap_top_degs.png" alt="DEG Heatmap">
    <p><strong>Heatmap</strong> - Top 50 differentially expressed genes with hierarchical clustering</p>
  </div>
  
  <div class="result-item">
    <img src="results/figures/pca_plot.png" alt="PCA Plot">
    <p><strong>PCA Plot</strong> - Sample clustering shows clear separation by condition</p>
  </div>
</div>

### Pathway Enrichment

<div class="results-gallery">
  <div class="result-item">
    <img src="results/figures/GO_BP_dotplot.png" alt="GO Enrichment">
    <p><strong>GO Enrichment</strong> - Top enriched biological processes</p>
  </div>
  
  <div class="result-item">
    <img src="results/figures/KEGG_dotplot.png" alt="KEGG Pathways">
    <p><strong>KEGG Pathways</strong> - Enriched signaling and metabolic pathways</p>
  </div>
</div>

---

## Understanding the Results

### Differential Expression Analysis

**What is a DEG?**  
A gene is considered differentially expressed if:
- Adjusted p-value (FDR) < 0.05 (statistically significant)
- |log2 fold change| > 1 (biologically meaningful)

**Interpreting fold change:**
- log2FC = 1 → 2-fold increase
- log2FC = -1 → 2-fold decrease
- log2FC = 2 → 4-fold increase

**Why adjusted p-value?**  
Multiple testing correction (Benjamini-Hochberg) controls false discovery rate when testing thousands of genes simultaneously.

### Pathway Enrichment

**Gene Ontology (GO):**
- **Biological Process:** What the gene does (e.g., "cell cycle regulation")
- **Molecular Function:** Biochemical activity (e.g., "kinase activity")
- **Cellular Component:** Where it acts (e.g., "nucleus")

**KEGG Pathways:**  
Curated molecular interaction networks (e.g., "MAPK signaling pathway")

**Significance:**  
p-value < 0.05 indicates the pathway contains more DEGs than expected by chance

---

## Troubleshooting

### Low Mapping Rates

**Problem:** <70% of reads map to genome

**Solutions:**
- Verify reference genome matches experiment organism and version
- Check for adapter contamination in FastQC
- Consider rRNA contamination
- Try alternative aligners (HISAT2)

### Memory Issues

**Problem:** STAR runs out of memory

**Solutions:**
```bash
# Reduce memory usage in STAR
--limitBAMsortRAM 30000000000  # 30GB

# Or process samples individually
for sample in sample1 sample2; do
    bash scripts/04_align_reads.sh $sample
done
```

### R Package Installation

**Problem:** Bioconductor packages fail to install

**Solution:**
```r
# Set specific Bioconductor version
BiocManager::install(version = "3.18")

# Install from source if binary fails
install.packages("package", type = "source")
```

---

## Best Practices

### Reproducibility
- ✅ Use version control (Git)
- ✅ Document software versions
- ✅ Use environment managers (Conda)
- ✅ Share code and data
- ✅ Write clear documentation

### Quality Control
- ✅ Check QC metrics at each step
- ✅ Visualize sample relationships (PCA, correlation)
- ✅ Validate top DEGs with independent methods
- ✅ Compare results with published studies

### Statistical Analysis
- ✅ Use appropriate statistical tests
- ✅ Apply multiple testing correction
- ✅ Set biological significance thresholds
- ✅ Report complete methodology

---

## Extensions

### Advanced Analyses

**Alternative Splicing:**
```bash
# Use rMATS for differential splicing
rMATS --b1 control.txt --b2 treatment.txt \
      --gtf genes.gtf --readLength 150
```


## Citations

**STAR aligner:**
> Dobin A, et al. (2013). STAR: ultrafast universal RNA-seq aligner. Bioinformatics. 29(1):15-21.

**DESeq2:**
> Love MI, et al. (2014). Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. Genome Biology. 15(12):550.

**clusterProfiler:**
> Wu T, et al. (2021). clusterProfiler 4.0: A universal enrichment tool for interpreting omics data. Innovation. 2(3):100141.

### Dataset

**GSE79018:**
> Moyon S, Huynh JL, Dutta D, et al. Functional Characterization of DNA Methylation in the Oligodendrocyte Lineage. Cell Rep. 2016;15(4):748-760. doi:10.1016/j.celrep.2016.03.060

---

<div class="author-info">
  <h3>About the Author</h3>
  <p><strong>Ipek Selcen, PhD</strong></p>
  <p>Biochemist specializing in chromatin biology and epigenetics. Passionate about making bioinformatics accessible through clear tutorials and reproducible workflows.</p>
  <p>
    <a href="https://github.com/ipekselcen">GitHub</a> | 
    <a href="https://linkedin.com/in/ipekselcen">LinkedIn</a> | 
    <a href="https://ipekselcen.github.io">Website</a>
  </p>
</div>

---

<p class="text-center text-muted">
  <small>Last updated: December 2025</small>
</p>

<style>
.project-header {
  text-align: center;
  margin: 2rem 0;
  padding: 2rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 10px;
}

.project-header h1 {
  margin-bottom: 0.5rem;
  color: white;
}

.project-header .lead {
  font-size: 1.25rem;
  margin-bottom: 1rem;
}

.badges {
  margin: 1rem 0;
}

.badge {
  display: inline-block;
  padding: 0.35em 0.65em;
  font-size: 0.875em;
  font-weight: 500;
  margin: 0.25rem;
  border-radius: 0.25rem;
}

.badge-primary { background-color: #007bff; color: white; }
.badge-success { background-color: #28a745; color: white; }
.badge-info { background-color: #17a2b8; color: white; }
.badge-secondary { background-color: #6c757d; color: white; }

.project-links {
  margin-top: 1.5rem;
}

.btn {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  margin: 0.5rem;
  text-decoration: none;
  border-radius: 0.25rem;
  font-weight: 500;
  transition: all 0.3s;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.tutorial-steps {
  margin: 2rem 0;
}

.tutorial-steps h3 {
  color: #667eea;
  border-left: 4px solid #667eea;
  padding-left: 1rem;
  margin-top: 2rem;
}

.results-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.result-item {
  text-align: center;
}

.result-item img {
  width: 100%;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  transition: transform 0.3s;
}

.result-item img:hover {
  transform: scale(1.05);
}

.author-info {
  margin-top: 3rem;
  padding: 2rem;
  background-color: #f8f9fa;
  border-radius: 8px;
  text-align: center;
}

code {
  background-color: #f4f4f4;
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 0.9em;
}

pre {
  background-color: #2d2d2d;
  color: #f8f8f2;
  padding: 1rem;
  border-radius: 5px;
  overflow-x: auto;
}
</style>
