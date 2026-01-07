---
layout: page
title: RNA-seq Analysis
description: A decision framework for experimental design and computational analysis
img: assets/img/rnaseq-intro.jpg
importance: 1
category: work
github: https://github.com/ipekselcen/rnaseq-tutorial
toc:
  sidebar: left
---

## Overview

RNA-seq has become the standard for transcriptome profiling, but the analytical landscape remains fragmented with competing tools, conflicting recommendations, and evolving best practices. This creates a challenge: **How do you make informed analytical choices when experts disagree?**

This tutorial provides a **conceptual framework** for RNA-seq analysis. Rather than prescribing a single "correct" pipeline, we examine the trade-offs between approaches and provide decision-making criteria based on your biological question, data characteristics, and computational constraints.

**The goal:** Understand *why* you make certain analytical choices, so you can adapt your approach to your specific needs and justify your decisions scientifically.

---

## The Core Question

Before writing any code or downloading any tools, answer this:

**What biological question are you asking?**

This determines everything downstream:
- Sequencing depth required
- Alignment strategy
- Quantification resolution
- Statistical approach
- Validation strategy

### Gene-Level Questions

*"Which genes are differentially expressed between conditions?"*

**Requires:**
- Gene-level quantification (sufficient)
- Moderate depth (~20-30M reads)
- Alignment-free methods work well
- Focus on statistical power

**Examples:**
- Treatment vs. control comparisons
- Knockout vs. wild-type
- Cell type identification
- Pathway enrichment analysis

### Transcript-Level Questions

*"Does my treatment affect alternative splicing?"*

**Requires:**
- Transcript-level quantification (essential)
- Higher depth (~40-60M reads)
- Genome alignment (for visualization)
- Specialized tools (DEXSeq, DRIMSeq)

**Examples:**
- Isoform switching
- Alternative splicing regulation
- Transcript-specific effects
- Splicing factor studies

> ##### WARNING
>
> **Critical decision:** If you don't care about isoforms, don't do transcript-level analysis. It:
> - Reduces statistical power (spreading signal across isoforms)
> - Increases computational cost
> - Complicates interpretation
> - Requires more sequencing depth
>
> **Save transcript analysis for when splicing is your biological question.**
{: .block-warning }

---

## Experimental Design Considerations

### The Replication Problem

**Statistical truth:** More replicates > more sequencing depth

| Design | Cost | Statistical Power | Recommendation |
|--------|------|------------------|----------------|
| n=2, 40M reads each | $ | Minimal | Avoid if possible |
| n=3, 25M reads each | $ | Good | Standard minimum |
| n=4, 20M reads each | $ | Better | Recommended |
| n=6, 15M reads each | $ | Best | Ideal for subtle effects |

**Why?** Biological variability between replicates is usually larger than technical noise. You need replicates to estimate that variability.

**Exception:** Pilot studies, rare samples, or prohibitive costs may force n=2. Acknowledge limitations in interpretation.

### Sequencing Depth Guidelines

**Not "how many reads do I need?"** but **"how many reads for my question?"**

| Application | Depth/Sample | Rationale |
|------------|--------------|-----------|
| Gene-level DE | 20-30M | Sufficient for abundant/moderate genes |
| Comprehensive profiling | 40-60M | Better low-expression gene detection |
| Isoform analysis | 50-100M | Required for transcript resolution |
| Novel transcript discovery | 60-100M | Depth enables junction detection |

**Diminishing returns:** Beyond ~30M reads for gene-level DE, you're paying more for modest gains.

---

## Alignment Strategies

### The Fundamental Trade-off

**Speed vs. Flexibility**

{% tabs alignment-strategy %}

{% tab alignment-strategy Pseudo-alignment %}
**Tools:** Kallisto, Salmon

**How it works:** Uses k-mer matching to estimate transcript abundance without creating alignment files.

**When to choose:**
- Gene-level differential expression
- Well-annotated organisms (human, mouse, rat)
- Limited computational resources
- Large sample sizes (>20 samples)
- No need for genome visualization

**Trade-offs:**
- ✓ 10-20x faster than genome alignment
- ✓ Low memory (~4-8 GB)
- ✓ Highly accurate for gene-level quantification
- ✗ Cannot visualize in IGV
- ✗ Cannot discover novel transcripts
- ✗ Requires good transcriptome reference

**Bottom line:** If your question is "which genes are differentially expressed," pseudo-alignment is sufficient and efficient.
{% endtab %}

{% tab alignment-strategy Genome Alignment %}
**Tools:** STAR (fast), HISAT2 (memory-efficient)

**How it works:** Aligns reads to reference genome, handles splicing, produces BAM files.

**When to choose:**
- Need genome browser visualization
- Novel transcript/junction discovery
- Integration with ChIP-seq or ATAC-seq
- Non-model organisms
- Allele-specific expression
- Publication requires BAM files

**Trade-offs:**
- ✓ Visualize in IGV for validation
- ✓ Discover novel junctions
- ✓ More flexible for downstream analyses
- ✗ Slower (15-30 min/sample vs. 5-10 min)
- ✗ High memory (STAR needs ~32GB)
- ✗ More storage (2-5 GB BAM/sample)

**Bottom line:** If you need to *see* your data or discover novel features, genome alignment is necessary.
{% endtab %}

{% endtabs %}

### Decision Framework

**Ask yourself:**

1. **Do I need to visualize alignments in IGV?**
   - Yes → Genome alignment
   - No → Continue

2. **Am I looking for novel transcripts/junctions?**
   - Yes → Genome alignment
   - No → Continue

3. **Is my transcriptome well-annotated?**
   - Yes → Pseudo-alignment
   - No → Genome alignment

4. **Do I have >30GB RAM available?**
   - Yes → STAR (fast and accurate)
   - No → Pseudo-alignment or HISAT2

---

## Normalization: Making Samples Comparable

### Why Raw Counts Aren't Enough

**Three problems:**

1. **Sequencing depth varies** - Sample A gets 25M reads, Sample B gets 20M
2. **Composition bias** - Highly expressed genes consume the "sequencing budget"
3. **Gene length** - Longer genes accumulate more reads (for same expression)

### Normalization Methods

| Method | Purpose | When to Use | Never Use For |
|--------|---------|-------------|---------------|
| **Raw counts** | DE testing input | DESeq2, edgeR | Comparisons, plots |
| **Size factors** | Between-sample | Built into DESeq2 | — |
| **TPM** | Cross-sample comparison | Visualization, heatmaps | DE testing |
| **FPKM/RPKM** | Legacy | Avoid | Everything |

> ##### DANGER
>
> **Never use TPM, FPKM, or RPKM for differential expression testing.**
>
> **Why?** These methods:
> - Violate statistical assumptions of DE tools
> - Remove variance information needed for testing
> - Can introduce false patterns
>
> **Always use raw counts for DESeq2/edgeR.**
>
> **Use TPM only for:**
> - Visualization (heatmaps, PCA)
> - Cross-sample comparison
> - Reporting expression levels
{: .block-danger }

---

## Differential Expression Analysis

### What These Tools Actually Do

All modern DE tools (DESeq2, edgeR, limma-voom) model RNA-seq count data using **negative binomial distributions**.

**Why negative binomial?**
- Counts aren't normally distributed
- Variance exceeds the mean (overdispersion)
- Handles low counts appropriately
- Accounts for biological variability

### Tool Selection

| Tool | Best For | Key Advantage | Consideration |
|------|---------|---------------|---------------|
| **DESeq2** | Most experiments | Robust, well-documented | Slower with >100 samples |
| **edgeR** | Large studies | Fast, scales well | More parameters to tune |
| **limma-voom** | Complex designs | Flexible modeling | Different framework |

**Recommendation:** Use DESeq2 unless you have specific reasons not to. It's the most widely adopted, has excellent documentation, and handles most experimental designs well.

### Understanding Statistical Output

**p-value vs. adjusted p-value (FDR):**

- **p-value:** Probability of observing this difference by chance (for *this gene*)
- **FDR (padj):** Expected proportion of false positives in your significant gene list

**Example:** FDR < 0.05 means if you have 100 significant genes, expect ~5 false positives.

**Effect size (log₂ fold change):**

- **log₂FC = 1:** 2-fold change
- **log₂FC = 2:** 4-fold change
- **log₂FC = -1:** 0.5-fold change (half)

> ##### TIP
>
> **Set biological thresholds:**
>
> **FDR < 0.05** controls false discovery rate  
> **|log₂FC| > 1** ensures at least 2-fold change
>
> **Why both?**
> - Statistical significance without large fold change might not be biologically relevant
> - Large fold change without significance might be noise
>
> Requiring both balances statistical rigor with biological meaning.
{: .block-tip }

---

## Quality Control: Trust But Verify

### The QC Philosophy

**QC isn't about generating perfect data.** It's about:
1. Detecting problems early (before wasting analysis time)
2. Understanding your data's limitations
3. Deciding if data answers your question

### Essential QC Checks

**Pre-alignment:**
- Per-base quality >Q28-30
- Adapter contamination <1%
- No unexpected GC bias
- Acceptable duplication (<60% for RNA-seq)

**Post-alignment:**
- Mapping rate >70% (ideally >85%)
- Uniquely mapped >60%
- Consistent across samples

**Post-quantification:**
- Samples cluster by biology (not batch)
- PC1 captures biological variation
- No outliers

### What QC Cannot Tell You

> ##### WARNING
>
> **High-quality data ≠ correct experiment**
>
> QC metrics assess technical quality. They don't validate:
> - Sample identity (are these the cells you think?)
> - Biological relevance (are you measuring what matters?)
> - Experimental design (do you have confounders?)
>
> **A technically perfect experiment with mislabeled samples is worthless.**
>
> Always validate sample identity independently (genotyping, markers, etc.).
{: .block-warning }

---

## Pathway Enrichment: Beyond Gene Lists

### What Enrichment Analysis Does

**The logic:**
If genes changed randomly, you'd see random pathways enriched. Coordinated changes in functionally related genes suggest biological programs.

**Tools:** clusterProfiler, DAVID, Enrichr, GSEA

**Databases:**
- **Gene Ontology (GO):** Biological processes, molecular functions
- **KEGG:** Metabolic and signaling pathways
- **Reactome:** Curated biological pathways
- **MSigDB:** Curated gene sets

### Interpretation Framework

| Finding | What It Means | What It Doesn't Mean |
|---------|--------------|---------------------|
| "DNA methylation" enriched | Methylation genes changed coordinately | Methylation is the cause |
| "Chromatin organization" significant | Epigenetic regulation involved | This is the mechanism |
| "p53 pathway" FDR < 0.001 | p53-related genes affected | p53 activity changed |

> ##### DANGER
>
> **Common mistakes in pathway interpretation:**
>
> **❌ "Pathway X is enriched, so that's THE mechanism"**
> - Enrichment identifies patterns, not causality
> - Multiple pathways can be enriched
> - Annotation bias can skew results
>
> **❌ "This gene is in the enriched pathway, so it's important"**
> - Being in an enriched pathway doesn't make a gene functionally critical
> - Pathway databases are incomplete and sometimes inaccurate
>
> **✓ Use enrichment to:**
> - Generate hypotheses
> - Identify candidate genes
> - Design validation experiments
> - Provide biological context
>
> **Then validate those hypotheses experimentally.**
{: .block-danger }

---

## From RNA to Biology

### The Validation Hierarchy

RNA-seq is a **hypothesis-generating tool**, not a hypothesis-testing tool.

**Validation levels:**

| Level | Method | What It Shows | Confidence |
|-------|--------|---------------|-----------|
| **Technical** | RT-qPCR | RNA change is real | Low |
| **Protein** | Western, IF | Protein changed too | Medium |
| **Functional** | Knockdown/overexpression | Gene is necessary/sufficient | High |
| **Mechanistic** | Rescue experiment | Change causes phenotype | Very High |

### Why RNA ≠ Biology

**Post-transcriptional regulation is pervasive:**

Studies comparing mRNA and protein levels find only **30-50% correlation**.

**Reasons:**
- MicroRNA regulation
- Translation efficiency varies
- Protein stability differs
- Subcellular localization
- Post-translational modification

> ##### TIP
>
> **Interpretation strategy:**
>
> 1. **RNA-seq:** Identifies *what* changed
> 2. **Pathway analysis:** Suggests *why* it might matter
> 3. **RT-qPCR:** Validates *RNA* changes are real
> 4. **Western blot:** Tests *protein* changes
> 5. **Functional assay:** Determines *biological* importance
> 6. **Rescue experiment:** Establishes *causality*
>
> Only after steps 1-6 can you claim mechanism.
{: .block-tip }

---

## Practical Considerations

### Computational Resources

**Realistic requirements for typical experiments:**

| Approach | RAM | CPU Cores | Time/Sample | Storage/Sample |
|----------|-----|-----------|-------------|----------------|
| Kallisto | 8 GB | 4 | 10 min | <1 GB |
| Salmon | 16 GB | 8 | 15 min | <1 GB |
| STAR | 32 GB | 8 | 25 min | 3-5 GB |
| HISAT2 | 10 GB | 8 | 30 min | 3-5 GB |

**For human/mouse, 50M PE reads**

**If resources are limited:**
- Use pseudo-alignment (Kallisto/Salmon)
- Process samples sequentially (not parallel)
- Use cloud computing for genome alignment
- Delete BAM files after quantification

### Reproducibility

**Essential practices:**

1. **Document software versions** - Tools change, results change
2. **Use environment management** - Conda, Docker
3. **Version control code** - Git for all scripts
4. **Record parameters** - Not just defaults
5. **Share raw data** - GEO, SRA

---

## Decision Framework Summary

### Your RNA-seq Checklist

**Before sequencing:**
- [ ] Biological question clearly defined
- [ ] Gene-level vs. transcript-level resolution decided
- [ ] Adequate biological replicates (n≥3)
- [ ] Appropriate sequencing depth

**Analysis approach:**
- [ ] Alignment strategy matches question
- [ ] Computational resources available
- [ ] QC metrics meet thresholds
- [ ] Normalization appropriate for use case

**Statistical testing:**
- [ ] Raw counts for DE testing
- [ ] Appropriate FDR threshold
- [ ] Biological effect size filter
- [ ] Multiple testing corrected

**Interpretation:**
- [ ] Pathway analysis as hypothesis generation
- [ ] Validation strategy planned
- [ ] RNA ≠ protein ≠ function acknowledged
- [ ] Experimental follow-up designed

---

## Key Principles

### 1. Match Method to Question

**There is no universally "best" pipeline.** The optimal approach depends on:
- Your biological question
- Your data characteristics
- Your computational resources
- Your validation strategy

### 2. Understand Trade-offs

Every analytical choice involves trade-offs:
- Speed vs. flexibility
- Sensitivity vs. specificity
- Complexity vs. interpretability
- Cost vs. depth

**Make informed decisions you can justify scientifically.**

### 3. RNA-seq Is a Tool, Not an Answer

**RNA-seq tells you:**
- Which genes' mRNA levels changed
- With what statistical confidence
- In what patterns

**RNA-seq doesn't tell you:**
- Why changes occurred
- Whether proteins changed
- If changes are functionally important
- What the mechanism is

**Use RNA-seq to ask better questions, then design experiments to answer them.**

---

## Related Resources

- **Case study:** [Dnmt1 Knockout Analysis](/projects/2_dnmt1-project/) - Complete workflow example
- **Code repository:** [GitHub]({{ page.github }}) - Documented analysis scripts
- **Tool documentation:**
  - [DESeq2 vignette](http://bioconductor.org/packages/DESeq2)
  - [Salmon manual](https://salmon.readthedocs.io)
  - [STAR documentation](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)

---

## Tutorial Philosophy

**Computational analysis serves biological understanding, not the other way around.**

Your domain expertise—understanding your cell type, developmental context, signaling pathways, and published literature—transforms gene lists into biological insight.

A perfectly executed computational pipeline that produces biologically meaningless results is worse than a rough analysis that generates testable, important hypotheses.

**Learn the tools. Understand the logic. Ask the biology.**