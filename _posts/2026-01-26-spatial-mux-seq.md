---
layout: post
title: "What Spatial-Mux-seq Adds to Tissue Epigenomics"
date: 2026-01-26
tags: spatial-omics multi-omics chromatin epigenetics
category: research-highlights
related_posts: true
---

One challenge in tissue epigenomics is connecting regulatory measurements to the location and state of the cells that produced them. Spatial-Mux-seq, published in *Nature Methods* in 2025, addresses this by measuring five modalities in a spatially resolved tissue section: two histone modifications, chromatin accessibility, whole-transcriptome RNA, and a panel of proteins.

I found the approach interesting because it puts several molecular measurements into a shared tissue context. That makes it possible to study relationships among modalities without relying only on comparisons between separately sampled sections.

## What the paper shows

The authors applied Spatial-Mux-seq to mouse embryos and mouse brains. Their analyses describe spatial and developmental relationships among histone modifications, chromatin accessibility, gene expression, and protein abundance during neuron differentiation. They also report a radial-glia niche with spatially dynamic epigenetic signals.

These are relationships observed across modalities and tissue locations. They are not, by themselves, proof that one molecular event causes another or a minute-by-minute timeline of differentiation. That distinction matters when interpreting methods that measure several features in the same specimen: co-occurrence and spatial pattern can sharpen a hypothesis, while causal order generally requires additional evidence.

The study's central technical contribution is the simultaneous, spatially resolved measurement of two histone modifications, chromatin accessibility, whole-transcriptome RNA, and proteins. The method was demonstrated in mouse tissues; applying it to other tissues or experimental questions would require considering its protocol, resolution, and sensitivity for each modality.

## What I found useful

Spatial-Mux-seq illustrates why keeping tissue context can matter in epigenomic studies. A molecular profile detached from its location may miss differences between neighboring populations. At the same time, measuring more modalities does not automatically make interpretation simpler: each assay has its own signal properties, and associations across layers still need careful analysis.

For me, the useful lesson is to match a method to the question. If the question concerns how multiple molecular layers are distributed in tissue, a multiplexed spatial assay may offer information that separate assays cannot. If the priority is maximum sensitivity for one modality, a dedicated assay may be more appropriate.

> Spatial-Mux-seq measures chromatin modifications, accessibility, gene expression, and proteins simultaneously in spatial context. The study describes relationships among these layers during mouse neuron differentiation and in a radial-glia niche.

|  |  |
| --- | --- |
| **Paper:** Guo et al., *Nature Methods* (2025) | [Read the paper →](https://www.nature.com/articles/s41592-024-02576-0) |

---

### Reference

- Guo P, et al. Multiplexed spatial mapping of chromatin features, transcriptome and proteins in tissues. *Nat Methods.* 2025;22(3):520-529. [doi:10.1038/s41592-024-02576-0](https://doi.org/10.1038/s41592-024-02576-0)