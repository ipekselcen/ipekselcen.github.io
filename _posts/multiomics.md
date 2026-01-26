---
layout: post
title: "When Chromatin Methods Converged: The Multi-Omics Revolution"
date: 2026-01-27
tags: epigenetics, computational-thinking, multi-omics, spatial-omics, chromatin
category: research-highlights
related_posts: true
toc:
  sidebar: left
---

> **Part 2 of 3:** We've learned decomposition, pattern recognition, and algorithmic thinking from individual methods. Now comes the hard part: integrating data types that were never meant to talk to each other.

---

## The Integration Problem

In 2020, a chromatin biologist staring at three different data types from the same tissue sample faced a fundamental challenge:

- **RNA-seq**: Counts of molecules (integers, Poisson-distributed)
- **ATAC-seq**: Chromatin accessibility (continuous signal, peaks)  
- **DNA methylation**: Binary status at each CG site (methylated or not)

Each assay answered a different question. Each had its own preprocessing pipeline, normalization strategy, and statistical assumptions. And yet, biology doesn't work in silos—gene expression depends on all of these layers simultaneously.

**The question wasn't "How do I analyze each dataset?"** It was **"How do I find relationships across fundamentally different data types?"**

This is the abstraction problem.

---

## Before Multi-Omics: The Single-Assay Trap

For decades, we asked narrow questions dictated by our methods:

- ChIP-seq: "Where does my transcription factor bind?"
- RNA-seq: "What genes are expressed?"
- ATAC-seq: "What regions are accessible?"
- Bisulfite-seq: "What's methylated?"

But biological questions are never this clean. Consider neuronal differentiation:

- Transcription factors bind to enhancers (ChIP-seq)
- Enhancers become accessible (ATAC-seq)
- Histone marks change from repressive to active (ChIP-seq with different antibodies)
- DNA methylation is removed at regulatory regions (bisulfite-seq)
- Target genes get transcribed (RNA-seq)

**Which happens first? Which are cause vs. consequence? Which changes are cell-autonomous?**

You can't answer these questions with one assay at a time.

---

## The First Attempts: Hacky but Functional (2015-2019)

Early multi-omics methods were ingenious workarounds:

**CITE-seq (2017)**: Antibodies with DNA barcodes  
- Measure proteins + RNA simultaneously
- Clever hack: DNA-tagged antibodies sequence alongside cDNA
- Limitation: Still just two modalities

**sci-CAR (2018)**: Combinatorial indexing for ATAC + RNA  
- Use molecular barcodes to track which reads came from which cells
- Limitation: Requires custom protocols, difficult to scale

**The pattern**: Each new combination required reinventing the wheel. No common framework existed.

---

## The Breakthrough: Abstraction

**2021: The realization that changed everything.**

Researchers at multiple labs independently discovered the same insight: all single-cell data, regardless of molecular source, can be represented using three components:

1. **Cell × Feature matrix** - What you measure
2. **Metadata** - Cell annotations, quality metrics  
3. **Dimensional reduction** - Shared latent space

Whether you're measuring:
- RNA counts per gene
- ATAC peaks per region  
- Methylation percentage per CG
- Protein abundance per epitope

...the computational framework is identical.

**This is abstraction**: Identifying common structure across different domains and building tools that operate at that level of generality.

---

> ##### Editorial Note: What Makes Multi-Omics Methods Publishable
>
> When evaluating multi-omics papers for Nature Methods, the key questions are:
>
> **1. Does it solve the pairing problem?**
> - Are measurements truly from the same cells?
> - Or is integration computational (which can work but has limitations)?
>
> **2. What's lost in the integration?**
> - Multi-omics often trades depth for breadth
> - Are you losing resolution/sensitivity compared to single-assay methods?
> - Is the tradeoff justified?
>
> **3. Does it enable new biology?**
> - Can you answer questions impossible with separate experiments?
> - Or does it just confirm what sequential assays would show?
>
> **4. Are the tools accessible?**
> - Can other labs implement this?
> - If only developers can analyze the data, adoption will be limited
>
> **Example comparison:**
> - **SHARE-seq (Ma et al., Cell 2020)**: Flexible, custom protocols, harder to adopt
> - **10x Multiome**: Commercial, standardized, lower barrier but less flexible
>
> Both valid, different niches. The best methods balance innovation with accessibility.
{: .block-tip }

---

## Case Study: Spatial-Mux-seq—Five Modalities, One Tissue

In January 2025, Guo, Deng, and colleagues published **Spatial-Mux-seq** in Nature Methods—immediately highlighted as one of the editors' favorite papers of the year.

**What they measured simultaneously:**
1. H3K27me3 (repressive histone mark)
2. H3K27ac (active histone mark)
3. Chromatin accessibility (ATAC)
4. Whole transcriptome (RNA)
5. Panel of proteins

**All in the same tissue section. All with spatial coordinates.**

Let's apply the full computational thinking framework to understand why this is significant:

### 1. Decomposition: Breaking Down the Technical Challenge

**Experimental workflow:**
1. Tissue section on slide
2. Tn5 transposase cuts accessible chromatin (ATAC)
3. Nanobody-Tn5 fusion proteins target histone marks
4. DNA-barcoded antibodies label surface proteins
5. In situ reverse transcription captures RNA
6. Spatial barcoding via microfluidic channels (creates tissue "pixels")
7. Sequence everything, decode spatial location

**Each step must work without interfering with the others.** That's the experimental challenge.

**Computational challenge:**
- Align five different data types to the same spatial coordinates
- Normalize each modality appropriately  
- Integrate despite different noise structures and dynamic ranges
- Enable biological interpretation

### 2. Pattern Recognition: What Did They Find?

**In mouse embryo development (E13):**

They discovered a **radial glia niche** with spatially dynamic epigenetic signals that weren't visible in single-modality data:

- H3K27me3 (repressive mark) was high in neural progenitors
- As cells differentiated → H3K27ac (active mark) increased
- Chromatin accessibility changed at enhancers *before* gene expression
- Protein markers confirmed cell identity

**Key insight:** The **temporal sequence** of molecular changes during differentiation was only visible because they measured all layers simultaneously in space.

**Bivalent chromatin domains** (regions with both H3K27me3 and H3K4me3) showed spatial organization in the developing brain—cells in the ventricular zone had different bivalent patterns than those in the cortical plate.

### 3. Algorithmic Thinking: The Integration Strategy

They used **Weighted Nearest Neighbor (WNN)** analysis—an algorithm that:

1. Calculates cell-cell similarity within each modality separately
2. Learns modality-specific weights based on information content  
3. Combines weighted similarities into unified cell neighborhoods

**Why this matters:** Not all modalities are equally informative for every cell type. WNN automatically upweights the most relevant signals.

**Example:** In neurons, gene expression might be highly informative. In oligodendrocytes, chromatin state might matter more. WNN adapts.

### 4. Abstraction: Fitting into the General Framework

Despite measuring five modalities, the data structure is still:

**Spatial pixels × Features matrix:**
- Features = genes + peaks + CG sites + proteins
- Each pixel has spatial coordinates (x, y)
- Standard Seurat/Signac analysis pipeline works

**This is why abstraction matters.** Once you structure the problem correctly, existing tools can handle novel combinations of measurements.

### 5. Critical Evaluation: When Does This Actually Help?

**Strengths:**
- Enables causal ordering (what changes first?)
- Captures spatial context (where in the tissue?)
- Identifies relationships invisible in single assays

**Limitations they acknowledge:**
- Lower sensitivity per modality vs. dedicated methods
- Requires fresh-frozen tissue
- Complex protocol (not every lab can implement)
- 20 μm spatial resolution (not single-cell, though cellular with deconvolution)

**When you should use this:**
- Developmental biology (temporal sequences matter)
- Tumor microenvironment (spatial organization matters)
- Anything where integration reveals emergent properties

**When you shouldn't:**
- You only care about one modality deeply
- Your question is answerable with sequential experiments
- You don't need spatial information

---

## The Abstraction That Made It Possible

**Look at what Spatial-Mux-seq builds on:**

**Tools developed 2020-2021:**
- Seurat WNN (2021): Multi-modal integration framework
- Signac (2021): Chromatin data in Seurat ecosystem
- ArchR (2021): Scalable scATAC-seq analysis

**Earlier spatial methods:**
- Spatial-ATAC-seq (Deng et al., Nature 2022)
- Spatial-CUT&Tag (Deng et al., Science 2022)
- DBiT-seq (Liu et al., Cell 2020)

**The innovation** isn't just the experimental protocol. It's recognizing that if you structure your data correctly, the computational tools already exist.

**That's abstraction in action.**

---

## The Multi-Omics Integration Toolkit

For biologists doing their own multi-omics analysis, here are the key conceptual tools:

**Seurat/Signac (R):**
```r
# Example workflow structure
seurat_obj <- CreateSeuratObject(counts = RNA_data)
seurat_obj[["ATAC"]] <- CreateChromatinAssay(ATAC_data)
seurat_obj[["Protein"]] <- CreateAssayObject(protein_data)

# Each modality gets normalized differently
seurat_obj <- NormalizeData(seurat_obj, assay = "RNA")
seurat_obj <- RunTFIDF(seurat_obj, assay = "ATAC")
seurat_obj <- NormalizeData(seurat_obj, assay = "Protein", method = "CLR")

# Integration via WNN
seurat_obj <- FindMultiModalNeighbors(seurat_obj, 
                                       reduction.list = list("pca", "lsi"),
                                       dims.list = list(1:30, 2:30))
```

**What's abstracted:**
- Same object structure holds different data types
- Functions know which normalization to apply
- Integration happens in shared latent space

**What you still need to understand:**
- Why TF-IDF for ATAC but not RNA?
- What does LSI capture that PCA doesn't?
- How are modalities weighted in WNN?

**Abstraction doesn't eliminate complexity.** It structures the problem so you can focus on the right questions.

---

## When Integration Doesn't Help: A Reality Check

Not all multi-omics is created equal.

**You DON'T need multi-omics when:**
- Separate experiments answer your question  
- Computational integration works as well as physical co-measurement
- The added complexity outweighs the insights

**You DO need multi-omics when:**
- Cell states are defined by modality combinations
- Temporal ordering matters (what changes first?)
- Spatial relationships between modalities are the question
- Correlations could be artifacts of cell-type averaging

**From experience:**

During my PhD studying TET2 in oligodendrocyte progenitor cells, I constantly felt I needed scRNA-seq + scATAC-seq from the same cells. But when I thought critically about my questions:

- Bulk ATAC-seq + scRNA-seq answered 90% of what I needed
- The extra cost/complexity of true single-cell pairing wasn't justified
- I was conflating "would be cool" with "necessary for my hypothesis"

**Critical evaluation** means knowing when simplicity beats sophistication.

---

## Looking Ahead: Where Multi-Omics Is Going (2025-2026)

**Current frontiers:**

**1. Spatial multi-omics at scale**
- Spatial-Mux-seq: 5 modalities in tissue
- DBiT-seq: Spatial RNA + protein
- Slide-tags: Spatial multi-omics with nuclear barcoding

**2. Temporal multi-omics**
- Lineage tracing + multi-modal readouts
- Time-resolved spatial profiling

**3. Perturbation + multi-omics**
- CRISPR screens with spatial context (Perturb-FISH)
- Drug perturbations with multi-modal readouts

**The next abstraction challenge**: How do you integrate:
- Space (where cells are)
- Time (developmental trajectories)  
- Perturbation (what happens when you manipulate them)
- Multiple molecular modalities

Tools are emerging (Seurat v5, moscato for optimal transport), but the conceptual framework is still being built.

---

## Transition to Part 3

We've learned four computational thinking skills:

1. **Decomposition** (bisulfite sequencing)
2. **Pattern recognition** (ATAC fragment lengths)
3. **Algorithmic thinking** (ChIP-seq peak calling)
4. **Abstraction** (multi-omics integration)

But there's one more skill we need—especially as AI models promise to revolutionize chromatin biology.

**Critical evaluation**: How do you tell when a new method is transformative vs. incremental? When does complexity add value vs. just noise? When should you trust a foundation model to design your enhancers?

**Part 3: Foundation Models in Chromatin Biology—Hype, Hope, and How to Tell the Difference**

---

## References

**Multi-omics foundations:**
- Ma, S. et al. (2020). "Chromatin Potential Identified by Shared Single-Cell Profiling of RNA and Chromatin." *Cell* 183(4):1103-1116. (SHARE-seq)
- Hao, Y. et al. (2021). "Integrated analysis of multimodal single-cell data." *Cell* 184:3573-3587. (Seurat WNN)
- Stuart, T. et al. (2021). "Single-cell chromatin state analysis with Signac." *Nature Methods* 18:1333–1341.

**Spatial multi-omics:**
- Guo, P. et al. (2025). "Multiplexed spatial mapping of chromatin features, transcriptome and proteins in tissues." *Nature Methods* 22:520–529. [PubMed](https://pubmed.ncbi.nlm.nih.gov/39870864/)
- Liu, Y. et al. (2020). "High-spatial-resolution multi-omics sequencing via deterministic barcoding in tissue." *Cell* 183:1665–1681. (DBiT-seq)
- Deng, Y. et al. (2022). "Spatial profiling of chromatin accessibility in mouse and human tissues." *Nature* 609:375–383. (Spatial-ATAC)
- Deng, Y. et al. (2022). "Spatial-CUT&Tag: spatially resolved chromatin modification profiling at the cellular level." *Science* 375:681–686.

**Computational frameworks:**
- Granja, J.M. et al. (2021). "ArchR is a scalable software package for integrative single-cell chromatin accessibility analysis." *Nature Genetics* 53:403–411.
- Cable, D.M. et al. (2022). "Robust decomposition of cell type mixtures in spatial transcriptomics." *Nature Biotechnology* 40:517–526. (RCTD cell type deconvolution)

---

**Next in this series:** *Part 3: Foundation Models in Chromatin Biology—Hype, Hope, and How to Tell the Difference*

---

*This is Part 2 of a 3-part series on computational thinking for chromatin biologists.*