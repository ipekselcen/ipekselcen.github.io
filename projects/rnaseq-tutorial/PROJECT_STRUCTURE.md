# RNA-seq Tutorial - Complete Project Structure

## Directory Tree

```
rnaseq-tutorial/
│
├── README.md                      # Main project documentation
├── GETTING_STARTED.md             # Quick start guide
├── .gitignore                     # Git ignore file
├── environment.yml                # Conda environment specification
│
├── data/                          # Data directory
│   ├── raw/                       # Raw FASTQ files (downloaded)
│   │   └── .gitkeep
│   ├── reference/                 # Reference genome and annotation
│   │   ├── Mus_musculus.GRCm39.dna.primary_assembly.fa
│   │   ├── Mus_musculus.GRCm39.115.gtf
│   │   ├── star_index/            # STAR genome index
│   │   └── .gitkeep
│   └── metadata.csv               # Sample metadata (generated)
│
├── scripts/                       # Analysis scripts
│   ├── 01_download_data.sh        # Download data from GEO
│   ├── 02_quality_control.sh      # FastQC and MultiQC
│   ├── 03_trim_reads.sh           # Trim Galore
│   ├── 04_align_reads.sh          # STAR alignment
│   ├── 05_count_reads.sh          # featureCounts
│   ├── 06_differential_expression.R  # DESeq2 analysis
│   ├── 07_pathway_analysis.R      # clusterProfiler enrichment
│   └── run_pipeline.sh            # Master pipeline script
│
├── notebooks/                     # R Markdown notebooks
│   └── RNA-seq_analysis.Rmd       # Interactive analysis notebook
│
├── docs/                          # Documentation
│   └── tutorial.md                # Detailed tutorial
│
└── results/                       # Analysis results
    ├── qc/                        # Quality control reports
    │   ├── raw/                   # Raw read QC
    │   └── trimmed/               # Trimmed read QC
    ├── aligned/                   # Alignment files
    │   ├── *_Aligned.sortedByCoord.out.bam
    │   ├── *_Log.final.out
    │   └── alignment_stats.csv
    ├── counts/                    # Read counts
    │   ├── gene_counts.txt
    │   ├── count_matrix_clean.txt
    │   └── count_summary.txt
    ├── deg/                       # Differential expression results
    │   ├── deseq2_results_all.csv
    │   ├── deseq2_results_significant.csv
    │   ├── normalized_counts.csv
    │   └── sessionInfo.txt
    ├── pathways/                  # Enrichment analysis results
    │   ├── GO_biological_process.csv
    │   ├── GO_molecular_function.csv
    │   ├── GO_cellular_component.csv
    │   ├── KEGG_pathways.csv
    │   ├── GSEA_GO_BP.csv
    │   └── sessionInfo.txt
    └── figures/                   # Publication-ready figures
        ├── pca_plot.png
        ├── sample_correlation.png
        ├── dispersion_plot.png
        ├── ma_plot.png
        ├── volcano_plot.png
        ├── heatmap_top_degs.png
        ├── top_upregulated_genes.png
        ├── GO_BP_dotplot.png
        ├── GO_BP_barplot.png
        ├── GO_BP_enrichment_map.png
        ├── KEGG_dotplot.png
        ├── GSEA_plot_*.png
        └── GO_BP_comparison.png
```

## File Descriptions

### Root Level Files

| File | Purpose |
|------|---------|
| `README.md` | Main project documentation with overview, installation, and usage |
| `GETTING_STARTED.md` | Quick start guide for beginners |
| `.gitignore` | Specifies files to exclude from version control |
| `environment.yml` | Conda environment with all dependencies |

### Scripts Directory

All scripts are executable (`chmod +x scripts/*.sh`)

| Script | Function | Input | Output | Runtime |
|--------|----------|-------|--------|---------|
| `01_download_data.sh` | Downloads FASTQ files from SRA, reference genome, and creates metadata | GEO accession | FASTQ files, reference files, metadata.csv | ~30 min |
| `02_quality_control.sh` | Runs FastQC and MultiQC on raw reads | FASTQ files | QC reports | ~20 min |
| `03_trim_reads.sh` | Trims adapters and low-quality bases | Raw FASTQ | Trimmed FASTQ | ~40 min |
| `04_align_reads.sh` | Aligns reads to genome with STAR | Trimmed FASTQ | BAM files, alignment stats | ~2 hours |
| `05_count_reads.sh` | Counts reads per gene | BAM files | Count matrix | ~20 min |
| `06_differential_expression.R` | DESeq2 analysis and visualization | Count matrix | DEG results, figures | ~15 min |
| `07_pathway_analysis.R` | GO and KEGG enrichment | DEG results | Pathway results, figures | ~20 min |
| `run_pipeline.sh` | Runs all steps sequentially | None | Complete analysis | ~4-6 hours |

### Analysis Parameters

#### Quality Control (02_quality_control.sh)
- FastQC: Default parameters
- MultiQC: Aggregates all FastQC reports

#### Trimming (03_trim_reads.sh)
- Quality threshold: Phred score ≥ 20
- Minimum length: 36 bp
- Adapter detection: Automatic (Illumina)
- Tool: Trim Galore (Cutadapt wrapper)

#### Alignment (04_align_reads.sh)
- Aligner: STAR v2.7.11a
- Genome: GRCm39 (Ensembl release 115)
- Splice junction overhang: 99
- Threads: 16
- Output: Coordinate-sorted BAM

#### Quantification (05_count_reads.sh)
- Tool: featureCounts (Subread)
- Mode: Paired-end, fragment counting
- Strand: Unstranded
- Multi-mapping: Not counted
- Multi-overlapping: Not counted

#### Differential Expression (06_differential_expression.R)
- Tool: DESeq2 v1.42.0
- Design: ~ condition
- Pre-filtering: ≥ 10 total reads
- Significance: FDR < 0.05
- Effect size: |log2FC| > 1
- Normalization: Median of ratios

#### Pathway Analysis (07_pathway_analysis.R)
- Tool: clusterProfiler v4.10.0
- Databases: GO, KEGG
- Enrichment: Over-representation analysis (ORA)
- GSEA: Ranked by log2FC × -log10(p-value)
- Correction: Benjamini-Hochberg (FDR)
- Significance: Adjusted p-value < 0.05

## Key Output Files

### Must-Check Results

1. **QC Report**
   - File: `results/qc/raw/raw_multiqc_report.html`
   - Check: Per-base quality, adapter content, duplication
   - Good: Quality > 30, minimal adapters

2. **Alignment Statistics**
   - File: `results/aligned/alignment_stats.csv`
   - Check: Uniquely mapped reads
   - Good: > 80% uniquely mapped

3. **DEG Results**
   - File: `results/deg/deseq2_results_significant.csv`
   - Contains: Gene IDs, log2FC, p-values, regulation status
   - Filtered: FDR < 0.05, |log2FC| > 1

4. **Normalized Counts**
   - File: `results/deg/normalized_counts.csv`
   - Use for: Downstream analysis, plotting

5. **Pathway Results**
   - Files: `results/pathways/*.csv`
   - Contains: Enriched terms, gene lists, statistics

### Publication-Ready Figures

All figures are saved as PNG (300 DPI):

| Figure | Shows | Use For |
|--------|-------|---------|
| `pca_plot.png` | Sample clustering | QC, experimental design validation |
| `volcano_plot.png` | DEG magnitude and significance | Main figure |
| `heatmap_top_degs.png` | Expression patterns of top DEGs | Main/supplementary figure |
| `GO_BP_dotplot.png` | Enriched biological processes | Main figure |
| `KEGG_dotplot.png` | Enriched pathways | Main/supplementary figure |

## Data Requirements

### Disk Space

| Component | Size | Notes |
|-----------|------|-------|
| FASTQ files (raw) | ~8-12 GB | 4 samples, paired-end |
| Reference genome | ~3 GB | GRCm39 uncompressed |
| STAR index | ~30 GB | Built from reference |
| BAM files | ~15-20 GB | Aligned reads |
| Results | ~2-3 GB | Counts, DEGs, figures |
| **Total** | **~60-70 GB** | **Complete pipeline** |


## Reproducibility

### Version Control

All software versions are specified in `environment.yml`:
- R 4.3
- DESeq2 1.42.0
- clusterProfiler 4.10.0
- STAR 2.7.11a
- FastQC 0.12.1
- MultiQC 1.19

### Session Information

Saved automatically:
- `results/deg/sessionInfo.txt` - R packages for DESeq2
- `results/pathways/sessionInfo.txt` - R packages for enrichment

### Complete Reproducibility

To reproduce this analysis:

```bash
# Clone repository
git clone https://github.com/ipekselcen/rnaseq-tutorial.git
cd rnaseq-tutorial

# Create environment
conda env create -f environment.yml
conda activate rnaseq

# Run pipeline
bash scripts/run_pipeline.sh
```

Results should be identical (within stochastic variation).

## Customization

### Using Your Own Data

1. **Place FASTQ files** in `data/raw/`
2. **Create metadata.csv** with columns: sample_id, condition, fastq_1, fastq_2
3. **Run pipeline**: `bash scripts/run_pipeline.sh skip-download`

### Changing Parameters

Edit the scripts to modify:
- Trim Galore: `--quality`, `--length`
- STAR: `--sjdbOverhang`, `--outFilterMultimapNmax`
- DESeq2: `padj` threshold, `log2FoldChange` cutoff
- clusterProfiler: `pvalueCutoff`, `qvalueCutoff`

### Different Organisms

1. **Update reference files** in `scripts/01_download_data.sh`
2. **Change organism database** in R scripts:
   - `org.Mm.eg.db` → `org.Hs.eg.db` (mouse)
   - `organism = "mmu"` → `organism = "hsa"` (human)

## Troubleshooting Guide

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Low mapping rate | Wrong reference genome | Verify genome version |
| Few DEGs | Insufficient replicates | Need ≥ 3 per condition |
| Memory error in STAR | Insufficient RAM | Reduce `--limitBAMsortRAM` |
| R package error | Missing dependencies | Reinstall with BiocManager |
| Empty pathway results | No gene ID conversion | Check organism database |

## Additional Resources

- **Tutorial Website**: [https://ipekselcen.github.io/projects/rnaseq-tutorial/](https://ipekselcen.github.io/projects/rnaseq-tutorial/)
- **GitHub Repository**: [https://github.com/ipekselcen/rnaseq-tutorial](https://github.com/ipekselcen/rnaseq-tutorial)
- **Issues/Questions**: [GitHub Issues](https://github.com/ipekselcen/rnaseq-tutorial/issues)
