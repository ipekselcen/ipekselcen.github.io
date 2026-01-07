---
layout: page
title: Dnmt1 Knockout Analysis
description: From transcriptional changes to biological mechanism - a case study in RNA-seq interpretation
img: assets/img/dnmt1-project.jpg
importance: 2
category: work
github: https://github.com/ipekselcen/rnaseq-tutorial
toc:
  sidebar: left
mermaid:
  enabled: true
  zoomable: true
---

## Overview

This project demonstrates how to extract biological insight from RNA-seq data through careful analytical design and interpretation. Using publicly available data (GSE79018), we investigate what happens when neonatal oligodendrocyte progenitors lose *Dnmt1*, the enzyme responsible for maintaining DNA methylation patterns during cell division.

**The central question:** Do cells recognize and respond to loss of epigenetic memory? And if so, how?

---

## Experimental Context

### Why This System Matters

Oligodendrocyte progenitors must maintain their identity while remaining capable of differentiation. This balance requires:
- Stable silencing of alternative lineage genes
- Maintained accessibility of differentiation programs
- Coordinated epigenetic control

*Dnmt1* maintains DNA methylation—a key epigenetic mark—through cell divisions. Its loss should destabilize cellular identity.

### Dataset Design

| Parameter | Value | Why It Matters |
|-----------|-------|----------------|
| **Cell type** | Neonatal OPCs | Actively dividing, dependent on Dnmt1 |
| **Genotype** | *Dnmt1* cKO vs Control | Clean knockout, no confounding mutations |
| **Replicates** | n=2 per condition | Minimum for statistical testing |
| **Sequencing** | PE 50bp, ~25M reads | Sufficient depth for gene-level DE |

> ##### TIP
>
> **Experimental strengths:** Simple comparison (one variable), biologically relevant system, adequate sequencing depth.
>
> **Limitations:** Only 2 replicates (limits power for subtle changes), single timepoint (can't distinguish immediate vs. delayed responses).
{: .block-tip }

---

## Analytical Framework

### The Logic of RNA-seq Analysis

RNA-seq doesn't directly answer biological questions. It generates a matrix of numbers (gene × sample counts). The analytical challenge is transforming that matrix into biological understanding:

1. **Quality control** - Are the numbers reliable?
2. **Normalization** - Are samples comparable?
3. **Statistical testing** - Which changes are real vs. noise?
4. **Biological interpretation** - What do the changes mean?

Each step involves trade-offs between sensitivity, specificity, and computational cost.

---

## Step 1: Quality Control

### What We're Really Asking

**Not:** "Did sequencing work?"  
**But:** "Can I trust these data to answer my biological question?"

### Key Metrics and Their Meaning

| Metric | Our Result | Interpretation |
|--------|-----------|----------------|
| **Reads/sample** | 24-26M | Adequate for gene-level DE (>20M threshold) |
| **Mean quality** | Q35 | High confidence in base calls |
| **Mapping rate** | 93% | Good sample quality, appropriate reference |
| **Duplication** | ~50% | Normal for RNA-seq (highly expressed genes) |

**Decision point:** All samples pass. Proceed without trimming.

> ##### WARNING
>
> **What QC doesn't tell you:** Whether your samples represent your biological question. A technically perfect dataset from mislabeled samples is useless. Validate sample identity independently.
{: .block-warning }

---

## Step 2: Alignment Strategy

### The Core Trade-off

**Alignment-free (Salmon/Kallisto):**
- Fast, low memory
- Sufficient for gene-level questions
- Cannot visualize in genome browser

**Genome alignment (STAR):**
- Slower, memory-intensive
- Enables visualization, novel junction detection
- Standard for publication

**Our choice:** STAR, because:
1. Dataset is manageable (4 samples)
2. We want genome browser validation
3. Computational resources available

[Complete alignment commands on GitHub →](https://github.com/ipekselcen/rnaseq-tutorial)

### What the Numbers Mean

**93% mapping rate** indicates:
- Good RNA quality (no degradation)
- Correct reference genome
- Minimal contamination
- Consistent across samples (no batch effects)

**Why this matters:** If mapping rates varied (e.g., 93% vs. 70%), we'd have a technical problem masquerading as biology.

---

## Step 3: From Reads to Counts

### The Quantification Challenge

After alignment, we need to assign reads to genes. Simple in concept, complex in practice:

**Challenges:**
- Multi-mapped reads (which gene gets the count?)
- Overlapping genes (shared exons)
- Isoform ambiguity (which transcript?)

**Our approach:** Gene-level quantification with featureCounts
- Counts fragments (not individual reads)
- Excludes multi-mappers (conservative)
- Assigns to genes (not transcripts)

**Result:** ~85% of fragments successfully assigned to genes.

**What we lose:** Isoform-level information  
**What we gain:** Statistical power, reduced complexity

---

## Step 4: Differential Expression

### The Statistical Framework

**What DESeq2 actually does:**

1. **Estimates sequencing depth** - Not all samples get equal reads
2. **Models biological variability** - Replicates aren't identical
3. **Accounts for low counts** - Genes with 5 reads are noisier than genes with 5,000
4. **Shrinks fold changes** - Prevents overstating changes in low-count genes
5. **Corrects for multiple testing** - Testing 18,000 genes inflates false positives

### Our Thresholds and Why

**FDR < 0.05:** Accept 5% false positives among significant genes  
**|log₂FC| > 1:** At least 2-fold change (biological relevance filter)

**Result:** 347 genes (198 up, 149 down)

> ##### TIP
>
> **Interpretation framework:**
>
> **FDR controls false discoveries** - If you validate 20 genes from your list, expect ~1 false positive.
>
> **Fold change indicates magnitude** - But doesn't equal biological importance. A 2-fold change in a master regulator matters more than 10-fold change in a metabolic enzyme.
{: .block-tip }

### What We Can and Cannot Conclude

**We can say:**
- These genes show statistically robust expression changes
- Changes are consistent across replicates
- Effect sizes exceed our threshold

**We cannot say:**
- These changes cause the phenotype
- Protein levels changed proportionally
- Changes are functionally important

---

## Results: The Biological Story

### Principal Component Analysis

**PC1 (68% variance) separates genotypes perfectly.**

**What this means:**
- The biological effect is strong (dominates technical noise)
- Replicates are consistent (cluster together)
- No obvious batch effects (would scatter samples)

**Why this matters:** If PC1 separated by batch rather than genotype, we'd have confounding we couldn't fully correct computationally.

### Differential Expression Pattern

**347 genes, but not randomly distributed:**

| Category | Count | Interpretation |
|----------|-------|----------------|
| Upregulated | 198 | More genes activated than repressed |
| Downregulated | 149 | Suggests cell attempting to compensate |
| Largest changes | 4-6 fold | Modest changes (not catastrophic) |

**Biological interpretation:** Cells aren't dying—they're responding. The modest fold changes suggest regulatory adjustments rather than wholesale transcriptional collapse.

---

## Pathway Analysis: Finding Patterns

### What Enrichment Analysis Actually Does

**The logic:** If random genes changed, we'd see random pathways. Coordinated changes in related genes suggest biological programs.

**Top enriched pathways:**

| Process | Gene Count | FDR | Biological Meaning |
|---------|-----------|-----|-------------------|
| Chromatin organization | 42 | 1.2e-08 | Epigenetic remodeling response |
| DNA methylation | 18 | 3.4e-07 | Direct functional category |
| Stem cell maintenance | 25 | 2.1e-06 | Identity stabilization programs |
| One-carbon metabolism | 15 | 8.3e-05 | Methyl donor supply chain |

### Interpreting the Pattern

**Three coordinated responses emerge:**

**1. Compensatory methylation machinery**
- *Dnmt3a* and *Dnmt3b* (de novo methyltransferases) upregulated
- Cell recognizes loss of methylation capacity
- Attempts to restore DNA methylation through alternative pathway

**2. Chromatin reorganization**
- Polycomb complexes upregulated
- Histone modifiers altered
- Suggests epigenetic compensation beyond methylation

**3. Metabolic adaptation**
- One-carbon metabolism genes affected
- These pathways generate methyl groups (SAM) for methylation
- Indicates metabolic stress or adaptation

> ##### DANGER
>
> **Critical distinction: Response vs. Mechanism**
>
> Pathway enrichment tells us what the cell is *doing* in response to Dnmt1 loss. It does not tell us:
> - Whether these responses are successful
> - Whether they're part of the problem or the solution
> - Which changes are direct vs. downstream
>
> **Example:** Dnmt3a/3b upregulation could be:
> - ✓ Successful compensation (restores some methylation)
> - ✗ Failed compensation (wrong enzyme for the job)
> - ✗ Pathological response (makes things worse)
>
> We need functional experiments to distinguish these possibilities.
{: .block-danger }

---

## Biological Interpretation

### The Dnmt1 Paradox

**Observation:** Cells upregulate other methyltransferases and chromatin regulators.

**Question:** If cells can compensate, why do Dnmt1 knockouts have phenotypes?

**Answer:** *Compensation is incomplete.*

**Evidence from literature:**
- Dnmt1 KO cells show global hypomethylation despite Dnmt3a/3b upregulation
- Differentiation is impaired despite chromatin remodeler activation
- Cells maintain progenitor markers despite attempting to differentiate

**Interpretation:** The cell recognizes the problem and responds, but the machinery it activates cannot fully substitute for Dnmt1's unique function of *maintaining* methylation through cell division.

### From Transcripts to Mechanism

**What our data show:**
- Transcriptional responses to Dnmt1 loss
- Coordinated activation of compensation pathways
- Metabolic and epigenetic reprogramming

**What we need to establish mechanism:**

| Question | Approach | Why It Matters |
|----------|----------|----------------|
| Do proteins change? | Western blot, IF | RNA ≠ protein |
| Are changes functional? | Knockdown Dnmt3a/3b in Dnmt1-KO | Test compensation |
| What's direct vs. indirect? | Dnmt1 ChIP-seq | Identify targets |
| Does methylation change? | Bisulfite-seq | Test central hypothesis |
| Can we rescue? | Restore Dnmt1 | Confirm causality |

---

## Testable Hypotheses

Based on this analysis, we can propose specific, testable hypotheses:

**Hypothesis 1: Compensatory Insufficiency**
- *Prediction:* Dnmt3a/3b upregulation partially restores methylation but not at critical loci
- *Test:* Bisulfite-seq of Dnmt1-KO + double KO (Dnmt1/3a/3b)
- *Expected result:* Double KO has worse phenotype than Dnmt1-KO alone

**Hypothesis 2: Chromatin Remodelers as Direct Targets**
- *Prediction:* Upregulated chromatin genes are normally repressed by Dnmt1-mediated methylation
- *Test:* Dnmt1 ChIP-seq + bisulfite-seq at their promoters
- *Expected result:* Dnmt1 binds these promoters; methylation is lost in KO

**Hypothesis 3: Metabolic Limitation**
- *Prediction:* Methylation capacity is limited by methyl donor availability
- *Test:* Supplement one-carbon metabolites (folate, methionine)
- *Expected result:* Partial rescue of methylation and/or phenotype

---

## Methods: Analytical Choices

### Why These Tools?

| Tool | Alternative | Our Choice | Rationale |
|------|-------------|------------|-----------|
| **Alignment** | Kallisto | STAR | Visualization needed, adequate resources |
| **Quantification** | RSEM | featureCounts | Gene-level sufficient, faster |
| **DE testing** | edgeR | DESeq2 | Better with few replicates, widely adopted |
| **Enrichment** | DAVID | clusterProfiler | Updated annotations, reproducible |

### Statistical Thresholds

**Pre-filtering:** Genes with <10 counts total removed
- Reduces multiple testing burden
- Removes non-expressed genes
- Improves dispersion estimation

**Significance:** FDR < 0.05, |log₂FC| > 1
- Standard stringency
- Fold change adds biological relevance filter
- Balances false positives vs. false negatives

### Software Environment

Complete computational environment specified in [`environment.yml`](https://github.com/ipekselcen/rnaseq-tutorial/blob/main/environment.yml) for full reproducibility.

---

## Code Repository

**Full workflow:** [github.com/ipekselcen/rnaseq-tutorial](https://github.com/ipekselcen/rnaseq-tutorial)

**Repository includes:**
- Complete analysis scripts (bash + R)
- Environment specifications
- Example data and results
- Documented notebooks with narrative

**Key scripts:**
- [`deseq2_analysis.R`](https://github.com/ipekselcen/rnaseq-tutorial/blob/main/scripts/deseq2_analysis.R) - Statistical analysis
- [`pathway_enrichment.R`](https://github.com/ipekselcen/rnaseq-tutorial/blob/main/scripts/pathway_enrichment.R) - GO/KEGG
- [`run_pipeline.sh`](https://github.com/ipekselcen/rnaseq-tutorial/blob/main/run_pipeline.sh) - Automated workflow

---

## Related Tutorials

- **[RNA-seq Analysis Guide](/projects/1_rnaseq-intro/)** - Methodological overview and decision framework
- **Original data:** [GEO: GSE79018](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE79018)

---

## Key Takeaways

**Computational rigor is necessary but not sufficient:**
- Statistics tell us which genes changed
- Biology tells us what those changes mean
- Experiments tell us whether our interpretations are correct

**Transcriptional changes are hypotheses:**
- RNA-seq identifies *what* changed
- Pathway analysis suggests *why* it might matter
- Functional validation determines *if* it matters

**Context determines interpretation:**
- Same fold change means different things in different genes
- Statistical significance ≠ biological importance
- Technical quality ≠ biological validity

**The goal:** Use computational analysis to ask better biological questions, then design experiments to answer them.