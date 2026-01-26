---
layout: post
title: "Seeing Five Molecular Layers at Once: How Spatial-Mux-seq Caught Development in the Act"
date: 2026-01-26
tags: spatial-omics, multi-omics, chromatin, development, epigenetics
category: research-highlights
related_posts: true
---

Here's a problem I kept running into during my PhD: I'd measure chromatin accessibility and see that enhancers were opening up. Then I'd measure gene expression and see genes turning on. But which happened first? And did the histone modifications change before or after the chromatin opened? 

The annoying part wasn't just that I couldn't answer these questions—it's that I couldn't even ask them properly. Each experiment destroyed the tissue, so I was always comparing different samples, different time points, hoping they were similar enough that the patterns I saw were real.

[Spatial-Mux-seq](https://www.nature.com/articles/s41592-024-02576-0), published this January in *Nature Methods* (and immediately highlighted as one of the editors' favorite papers of 2025), solves this by measuring five molecular layers simultaneously in the same tissue section: two histone modifications, chromatin accessibility, gene expression, and proteins. All with spatial coordinates.

Think of it like watching a dance from five different camera angles at once. Suddenly you can see not just the individual movements, but the choreography.

## What Makes This Hard (and Why It Matters)

Measuring one thing in tissue is straightforward. Measuring two things simultaneously gets tricky. Five things? That requires some serious molecular gymnastics.

The challenge isn't just technical—it's conceptual. Each molecular layer has different properties:
- **Histone modifications**: Binary marks at specific genomic locations
- **Chromatin accessibility**: Continuous signal across peaks
- **RNA**: Count data, lots of zeros, highly dynamic
- **Proteins**: Surface markers, relatively stable

How do you normalize these against each other? How do you know if a correlation you see is real or just an artifact of how you processed the data? And most importantly: can you structure the output so people can actually analyze it?

The Penn Medicine team (Yanxiang Deng, Pengfei Guo, Marek Bartosovic, and colleagues) solved this by building on existing spatial methods they'd developed (Spatial-ATAC, Spatial-CUT&Tag) and recognizing something crucial: **if you structure multi-omics data correctly, the computational tools already exist.**

## What They Found (And Why It's Surprising)

**Bivalent chromatin isn't randomly scattered**

Bivalent domains—regions marked by both activating (H3K4me3) and repressive (H3K27me3) histone modifications—poise developmental genes for rapid activation. We've known about them for years. But nobody had mapped their spatial organization in developing tissue.

In E13 mouse embryos, bivalent domains showed striking spatial patterns. Neural progenitors near the ventricular surface had completely different bivalent signatures than differentiating neurons in the cortical plate, even when they expressed similar genes. Position in the tissue mattered.

**Epigenetics changes *before* transcription**

By measuring histone marks, chromatin state, and gene expression in the same cells, they could determine temporal ordering during neuron differentiation:

1. H3K27me3 (repressive mark) drops first
2. Chromatin opens at enhancers
3. H3K27ac (active mark) appears
4. Gene expression follows

This sequence was invisible in separate experiments because the timing is tight—maybe hours between steps. Traditional approaches with different tissue samples would miss it.

**Radial glia populations differ epigenetically, not transcriptionally**

Here's the sneaky one: they found distinct radial glia subpopulations that looked nearly identical by RNA-seq but had dramatically different chromatin states.

Cells near the ventricular surface: high H3K27me3, low accessibility—genes are poised but silent. Cells in the intermediate zone: transitioning chromatin, starting to activate neuronal programs. The gradient was sharp and spatial.

If you'd only done RNA-seq, you'd have called these the same cell type. The epigenetic layer revealed hidden heterogeneity.

## The Innovation Isn't Just Measuring Five Things

What makes this publishable in *Nature Methods* rather than "just" an application paper?

**They made it usable.**

Despite measuring five modalities, the output is still a standard **spatial pixels × features matrix**. Same structure as single-modality spatial transcriptomics. Which means Seurat, Signac, and ArchR—tools labs already know—can handle the analysis.

They used Weighted Nearest Neighbor (WNN) analysis to integrate modalities, which automatically learns which data types matter most for each cell type. In neurons, gene expression might be most informative. In oligodendrocytes, chromatin state might dominate. The algorithm adapts.

**The protocol builds on existing methods.** They're not reinventing everything—they're cleverly combining Spatial-ATAC, Spatial-CUT&Tag (both from the Deng lab), and spatially-barcoded RNA-seq. Each piece has been validated separately.

**They're honest about limitations:**
- Lower sensitivity per modality compared to dedicated methods
- 20 μm spatial resolution (not single-cell, though cellular with deconvolution)
- Requires fresh-frozen tissue and specialized nanobody-Tn5 conjugates
- Complex protocol—not every lab can implement this tomorrow

This is exactly the kind of transparency that builds trust.

## When Should You Actually Use This?

**Use Spatial-Mux-seq when:**
- Temporal ordering of molecular events is your question
- Spatial context matters (tumor microenvironment, developmental niches)
- Integration reveals emergent properties invisible to single assays

**Don't use it when:**
- You care deeply about one modality and need maximum sensitivity
- Sequential experiments would answer your question
- You don't need spatial information
- Your lab can't access fresh-frozen tissue or the technical infrastructure

The authors are clear about this in their discussion. Not every problem needs five modalities.

## What This Means for the Field

Multi-omics methods are maturing. Early demonstrations (2017-2020) proved you *could* measure two things at once. Now we're seeing methods that measure five modalities while remaining practical enough for adoption.

The shift mirrors what happened with scRNA-seq: early methods were heroic technical achievements. Now they're routine. Spatial-Mux-seq isn't routine yet—but it's moving that direction.

And here's what excites me: they're making the data structure compatible with existing tools. That's how methods get adopted. Not by being revolutionary, but by fitting into workflows people already use.

> **Bottom Line:** Spatial-Mux-seq measures chromatin modifications, accessibility, gene expression, and proteins simultaneously in tissue. The key biological insight: epigenetic changes precede transcription, bivalent chromatin is spatially patterned, and radial glia show hidden heterogeneity in chromatin state. The key methodological insight: structure your multi-omics data correctly and existing computational tools work. That's what makes this publishable—and usable.

|  |  |
| --- | --- |
| **Paper:** Guo et al., *Nature Methods* (2025) | [Read the paper →](https://www.nature.com/articles/s41592-024-02576-0) |
| **Highlighted by:** Nature Methods editors as one of their favorite papers of 2025 |  |

---

### References

- Guo P, Mao L, Chen Y, et al. Multiplexed spatial mapping of chromatin features, transcriptome and proteins in tissues. *Nat Methods.* 2025;22(3):520-529.
- Deng Y, Bartosovic M, Ma S, et al. Spatial profiling of chromatin accessibility in mouse and human tissues. *Nature.* 2022;609:375-383.
- Deng Y, Bartosovic M, Kukanja P, et al. Spatial-CUT&Tag: spatially resolved chromatin modification profiling at the cellular level. *Science.* 2022;375:681-686.
- Liu Y, Yang M, Deng Y, et al. High-spatial-resolution multi-omics sequencing via deterministic barcoding in tissue. *Cell.* 2020;183(6):1665-1681.
- Ma S, Zhang B, LaFave LM, et al. Chromatin Potential Identified by Shared Single-Cell Profiling of RNA and Chromatin. *Cell.* 2020;183(4):1103-1116.
- Hao Y, Hao S, Andersen-Nissen E, et al. Integrated analysis of multimodal single-cell data. *Cell.* 2021;184(13):3573-3587.
- Stuart T, Srivastava A, Madad S, Lareau CA, Satija R. Single-cell chromatin state analysis with Signac. *Nat Methods.* 2021;18(11):1333-1341.
- Granja JM, Corces MR, Pierce SE, et al. ArchR is a scalable software package for integrative single-cell chromatin accessibility analysis. *Nat Genet.* 2021;53(3):403-411.
- Cao J, Spielmann M, Qiu X, et al. The single-cell transcriptional landscape of mammalian organogenesis. *Nature.* 2019;566(7745):496-502.