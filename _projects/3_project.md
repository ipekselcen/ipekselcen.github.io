---
layout: page
title: H4K8ac ChIP-seq Analysis
description: How chromatin accessibility shapes adult oligodendrocyte progenitor identity and function
img: assets/img/chipseq-project.jpg
importance: 3
category: work
github: https://github.com/ipekselcen/chipseq-tutorial
toc:
  sidebar: left
---

## Overview

This project investigates how histone modifications regulate the unique properties of adult oligodendrocyte progenitors (aOPCs) in the brain. Using ChIP-seq for H4K8 acetylation—an activating chromatin mark—we reveal how epigenetic mechanisms maintain progenitor identity while preparing cells for rapid differentiation when needed.

**Published in:** *Journal of Cell Biology* (2024)  
**Citation:** Dansu DK\*, Selcen I\*, et al. Histone H4 acetylation differentially modulates proliferation in adult oligodendrocyte progenitors. *J Cell Biol* 223(11):e202308064. [[DOI]](https://doi.org/10.1083/jcb.202308064)

*\*Co-first authors*

---

## The Biological Question

### Why Adult OPCs Matter

Adult oligodendrocyte progenitors represent ~5% of cells in the adult brain. Unlike most adult stem cells that are quiescent, aOPCs remain distributed throughout white and gray matter, capable of generating new myelin-forming oligodendrocytes throughout life.

**Clinical relevance:**
- Essential for myelin repair after injury
- Dysregulated in multiple sclerosis
- Decline with aging contributes to cognitive changes
- Therapeutic targets for remyelination strategies

### The Puzzle

Adult and neonatal OPCs are transcriptionally distinct:
- aOPCs proliferate slower
- aOPCs respond differently to growth factors
- aOPCs express genes closer to mature oligodendrocytes
- Yet aOPCs maintain progenitor capacity

**Question:** What epigenetic mechanisms maintain this unique adult progenitor state—balanced between self-renewal and differentiation readiness?

---

## Experimental Strategy

### Why H4K8 Acetylation?

**Discovery approach:** Unbiased histone proteomics identified H4K8ac as enriched in adult vs. neonatal OPCs.

**Biological significance:**
- H4K8ac is an activating histone mark
- Associates with accessible chromatin
- Present at actively transcribed genes
- Can "prime" genes for future activation

**Hypothesis:** H4K8ac distribution differs between adult and neonatal OPCs in functionally meaningful ways.

### Dataset Design

| Parameter | Value | Rationale |
|-----------|-------|-----------|
| **Cell type** | PDGFRα+ OPCs | Bona fide OPC marker |
| **Timepoints** | P5 (neonatal), P60 (adult) | Established developmental stages |
| **Replicates** | n=3 per condition | Adequate for ChIP-seq differential binding |
| **Controls** | Matched input DNA | Essential for ChIP normalization |
| **Validation** | Western blot, peptide array | Antibody specificity confirmed |

---

## ChIP-seq Analysis Framework

### ChIP-seq vs. RNA-seq: Different Questions

**RNA-seq asks:** What genes are transcribed?  
**ChIP-seq asks:** Where is this protein (or mark) bound in the genome?

**Key differences:**

| Aspect | RNA-seq | ChIP-seq |
|--------|---------|----------|
| **Signal** | Gene expression | Protein-DNA binding |
| **Resolution** | Gene-level | Genomic loci (~200bp) |
| **Quantification** | Counts per gene | Read density per region |
| **Noise** | Low (clear signal) | Higher (background binding) |
| **Validation** | RT-qPCR | ChIP-qPCR |

> ##### TIP
>
> **ChIP-seq advantages:**
> - Identifies *where* regulation occurs (promoter, enhancer, gene body)
> - Reveals binding even without transcriptional changes
> - Maps regulatory elements genome-wide
>
> **ChIP-seq limitations:**
> - Correlation ≠ function (binding ≠ activity)
> - Requires millions of cells (challenging for rare populations)
> - Antibody quality is critical
{: .block-tip }

---

## Step 1: Quality Control

### What Defines Good ChIP-seq?

Unlike RNA-seq where quality is straightforward, ChIP-seq quality depends on **enrichment strength** relative to background.

### Critical QC Metrics

| Metric | Our Results | Interpretation |
|--------|-------------|----------------|
| **Mapping rate** | >85% | Good sequencing quality |
| **Duplication rate** | <25% | Sufficient library complexity |
| **FRiP score** | 3-8% | Modest but acceptable enrichment |
| **NSC** | >1.2 | ChIP enrichment vs. background |
| **RSC** | >0.9 | Enrichment quality |

**FRiP (Fraction of Reads in Peaks):**
- Transcription factors: typically 5-20%
- Histone modifications: typically 1-10%
- Our H4K8ac: 3-8% (appropriate for broad mark)

> ##### WARNING
>
> **FRiP depends on mark type:**
>
> **Sharp peaks** (transcription factors): Higher FRiP expected  
> **Broad marks** (histone modifications): Lower FRiP is normal
>
> Don't compare FRiP across different types of ChIP experiments.
{: .block-warning }

---

## Step 2: Peak Calling Strategy

### Broad vs. Narrow Peaks

**The choice matters:**

**Narrow peaks (default MACS2):**
- For transcription factors
- Sharp, defined binding sites
- Typical width: 100-500 bp

**Broad peaks (MACS2 --broad):**
- For histone modifications
- Extended genomic regions
- Typical width: 500-5000 bp

**Our choice:** Broad peak calling (`--broad --broad-cutoff 0.01`)

**Why?** H4K8ac marks nucleosomes across extended regions, not discrete binding sites.

### The Input Control Question

**Why we need input:**
- Genomic DNA accessibility varies
- Some regions naturally accumulate reads
- GC content affects sequencing
- Repetitive regions create artifacts

**What input tells us:** This ChIP enrichment exceeds what you'd expect from genomic background alone.

---

## Step 3: Differential Binding Analysis

### The Core Challenge

**Not:** "Where is H4K8ac present?"  
**But:** "Where does H4K8ac differ between adult and neonatal OPCs?"

### Analytical Approach

We used **two independent methods:**

1. **MACS2 bdgdiff** - Fold-change based
2. **diffReps** - Window-based statistical testing

**Why both?** Combining methods reduces false positives. Sites identified by both are high-confidence.

**Results:** 35,820 differential H4K8ac sites (FDR < 0.01)
- **95% enriched in adult OPCs**
- **5% enriched in neonatal OPCs**

### What This Pattern Means

The dramatic adult enrichment suggests:
- aOPCs don't simply lose neonatal marks
- aOPCs gain a more complex chromatin landscape
- Additional regulatory layers accumulate with maturation

---

## Results: The Adult Chromatin Landscape

### Genomic Distribution

H4K8ac sites aren't randomly distributed:

| Region | Adult-enriched sites | Biological meaning |
|--------|---------------------|-------------------|
| **Promoters** | 28% | Gene activation |
| **Gene bodies** | 45% | Active transcription |
| **Intergenic** | 27% | Enhancers, regulatory elements |

**Interpretation:** Adult-enriched H4K8ac marks both active genes (promoters/gene bodies) and poised regulatory elements (intergenic enhancers).

### Functional Categories

**Three major categories emerged from pathway enrichment:**

#### 1. Progenitor Identity Genes

**Examples:** *Hes5*, *Sox9*, *Gpr17*, *Pdgfra*

**Meaning:** These genes maintain the progenitor state. H4K8ac marks them for continued expression, preventing premature differentiation.

**Why this matters:** aOPCs must remain progenitors while being "older" and more mature than nOPCs.

#### 2. Metabolic Adaptation Genes

**Examples:** *Txnip*, *Ptgds*, lipid metabolism enzymes

**Meaning:** Adult brain has different metabolic demands than developing brain. aOPCs mark metabolic genes appropriate for mature CNS environment.

**Why this matters:** Explains why aOPCs behave differently from nOPCs in culture—they're adapted to different metabolic contexts.

#### 3. Myelin Gene Priming

**Examples:** *Cnp*, *Mog*, *Mbp*, *Plp1*

**Meaning:** Despite being progenitors, aOPCs already mark myelin genes with H4K8ac. This creates "poised chromatin"—genes ready for rapid activation.

**Why this matters:** Explains how aOPCs can quickly respond to demyelination—the chromatin is already accessible.

---

## Biological Interpretation

### The Poised Progenitor Model

Our data support a model where adult OPCs are **primed but not committed:**

**Chromatin states:**
1. **Progenitor genes** → Active H4K8ac, currently transcribed
2. **Metabolic genes** → Active H4K8ac, supporting adult metabolism
3. **Myelin genes** → Poised H4K8ac, ready but not yet transcribing

**The balance:**
- Enough activation to maintain identity
- Enough priming for rapid differentiation
- Enough repression to prevent premature commitment

### Why This Matters for Function

The distinct H4K8ac landscape explains functional observations:

| Observation | Chromatin explanation |
|-------------|---------------------|
| Slower proliferation | Cell cycle genes lack H4K8ac |
| Maintained progenitor markers | Progenitor genes marked with H4K8ac |
| Rapid differentiation capacity | Myelin genes pre-marked (poised) |
| Metabolic differences | Adult-specific metabolic gene marking |

---

## From Chromatin to Mechanism

### What ChIP-seq Tells Us

**Can say:**
- H4K8ac is present at these genomic locations
- Distribution differs between adult and neonatal
- Enrichment correlates with gene categories

**Cannot say:**
- Whether H4K8ac causes these functional differences
- Whether acetylation is actively regulated or constitutive
- Which acetyltransferases deposit this mark
- Whether removing H4K8ac changes cell behavior

### Validation Strategy

**Paper included:**

| Approach | What it tests | Result |
|----------|---------------|---------|
| **ChIP-qPCR** | ChIP-seq accuracy | Confirmed differential sites |
| **Functional assays** | Role of acetyltransferases | HAT inhibition reduced proliferation |
| **RNA-seq integration** | Correlation with expression | H4K8ac sites near expressed genes |
| **Genetic manipulation** | Causality | HAT perturbation altered OPC behavior |

> ##### DANGER
>
> **ChIP-seq is descriptive, not mechanistic.**
>
> **What we learned from ChIP-seq:**  
> H4K8ac landscape differs between adult/neonatal OPCs
>
> **What required functional experiments:**  
> Whether H4K8ac regulates the differences
>
> **Critical distinction:** Correlation (ChIP-seq) vs. causation (functional experiments)
{: .block-danger }

---

## Methods: Key Decisions

### Why These Approaches?

| Decision | Alternative | Our Choice | Rationale |
|----------|-------------|------------|-----------|
| **Cell isolation** | Dissection | FACS sorting | Purity critical for ChIP |
| **ChIP method** | Native | Cross-linked | Better for histones |
| **Peak caller** | Epic2, SICER | MACS2 | Standard, well-validated |
| **Differential** | DiffBind | MACS2 + diffReps | Consensus increases confidence |

### Analytical Thresholds

**Peak calling:** FDR < 0.01, fold enrichment > 3  
**Differential binding:** FDR < 0.01, identified by both methods  
**Pathway enrichment:** FDR < 0.05, minimum 5 genes

**Why stringent?** ChIP-seq has higher false positive rates than RNA-seq. Conservative thresholds reduce noise.

### Computational Environment

Complete workflow with software versions available on GitHub: [chipseq-tutorial](https://github.com/ipekselcen/chipseq-tutorial)

**Key tools:**
- Bowtie2 for alignment
- MACS2 for peak calling
- ChIPseeker for annotation
- clusterProfiler for enrichment

---

## Clinical Implications

### Remyelination Therapy

**Current challenge:** Stimulating endogenous OPCs to remyelinate after injury

**Our findings suggest:**
- aOPCs have poised myelin genes (chromatin already accessible)
- HAT activity regulates progenitor state
- Chromatin modifiers are druggable targets

**Potential strategies:**
- HAT activators to enhance differentiation capacity
- Maintaining poised chromatin states
- Age-specific epigenetic therapies

### Beyond Myelin

**Broader relevance:**
- How adult stem cells balance identity and potency
- Epigenetic mechanisms of cellular aging
- Chromatin priming as a regulatory strategy

---

## Key Takeaways

### Biological Insights

**Adult OPCs maintain a unique chromatin state:**
- Progenitor genes actively marked
- Metabolic genes adapted to adult CNS
- Myelin genes poised for differentiation

**This explains their functional properties:**
- Maintained progenitor capacity
- Reduced proliferation
- Rapid differentiation potential

### Methodological Lessons

**ChIP-seq reveals regulatory potential:**
- Where marks are (genomic locations)
- When marks differ (adult vs. neonatal)
- What genes are regulated (annotation)

**But requires functional validation:**
- Correlation ≠ causation
- Presence ≠ activity
- Marking ≠ transcription

**Combine approaches:**
- ChIP-seq for location
- RNA-seq for expression
- Functional assays for mechanism

---

## Data & Code Availability

**Raw sequencing data:** [GEO: GSE263808](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE263808)  
**Processed data:** BigWig tracks, peak calls, differential binding results on GEO  
**Analysis code:** [GitHub: chipseq-tutorial](https://github.com/ipekselcen/chipseq-tutorial)  
**Publication:** [JCB 2024](https://doi.org/10.1083/jcb.202308064)

---

## Related Resources

- **RNA-seq tutorial:** [RNA-seq Analysis Guide](/projects/1_rnaseq-intro/)
- **Case study:** [Dnmt1 Analysis](/projects/2_dnmt1-project/) - Epigenetic regulation of OPCs

---

**Project Philosophy:** Epigenomic profiling reveals regulatory potential but requires functional validation to establish mechanism. ChIP-seq maps the chromatin landscape; experiments test whether that landscape shapes cellular behavior. Use both to move from description to understanding.