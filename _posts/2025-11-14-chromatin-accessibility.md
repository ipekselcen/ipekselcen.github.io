---
layout: post
title: "Chromatin Accessibility: Open and Closed Chromatin"
date: 2025-11-14
categories: [editorial]
tags: [writing, chromatin]
---

# Introduction
Your genome contains about 3 billion base pairs of DNA, all packed into a nucleus that's only about 5 micrometers across. If you stretched out all the DNA from one cell, it would be roughly 2 meters long. How does the cell pack all this DNA and still allow access to the genes that need to be read?
The answer is chromatin—the combination of DNA and proteins that makes up our chromosomes. But not all chromatin is packaged the same way. Some regions are tightly packed and inaccessible, while others are loosely organized and accessible. This accessibility determines which parts of the genome can be read by the cell's machinery. Understanding chromatin accessibility is fundamental to understanding how genes are regulated.

# Open vs. Closed Chromatin
DNA wraps around histone proteins to form nucleosomes—the basic units of chromatin. Each nucleosome consists of DNA wound around eight histone proteins (two copies each of H2A, H2B, H3, and H4). When nucleosomes pack together tightly, they form closed chromatin (also called heterochromatin), which is generally inactive. When nucleosomes are spaced out or absent, the DNA is in open chromatin (euchromatin), which allows transcription factors and other regulatory proteins to bind.
This isn't just a binary on/off state. Chromatin exists along a spectrum from completely inaccessible to highly accessible. Different genomic regions have different levels of accessibility depending on:

- How many nucleosomes are present
- How tightly nucleosomes are packed
- Which histone modifications are present
- Whether the DNA is methylated
- Which chromatin remodeling enzymes are active

# What Makes Chromatin Accessible?
Several mechanisms control whether chromatin is open or closed:

#Nucleosome Positioning and Depletion
The position of nucleosomes along DNA is not random. At active genes, the region right before the transcription start site (called the promoter) often has few or no nucleosomes—this is called a nucleosome-depleted region (NDR). This NDR allows transcription factors to bind and recruit RNA polymerase to start transcription.
Richard Kornberg and others showed decades ago that nucleosome positioning affects gene expression. More recently, genome-wide studies revealed that nucleosome positions are precisely organized at active genes, with characteristic spacing patterns. The nucleosomes flanking promoters (called the -1 and +1 nucleosomes) are often very well-positioned.

# Chromatin Remodeling Complexes
Cells use ATP-powered molecular machines called chromatin remodelers to move, eject, or restructure nucleosomes. There are several families of these remodelers:

- SWI/SNF complexes can slide nucleosomes along DNA or completely remove them, opening up DNA for transcription factor binding
- ISWI complexes typically space nucleosomes evenly and help organize chromatin structure
- CHD complexes can both remodel nucleosomes and recognize histone modifications
- INO80 complexes exchange histone variants and help with DNA repair

These remodelers don't work randomly—they're recruited to specific genomic locations by transcription factors and other regulatory proteins.

# Histone Modifications
Chemical modifications on histone proteins affect how tightly DNA wraps around nucleosomes. Acetylation of histones (particularly H3K27ac) generally makes chromatin more accessible by loosening the interaction between DNA and histones. Deacetylation by histone deacetylases (HDACs) typically makes chromatin less accessible.
Other modifications create binding sites for proteins that can further open or close chromatin. For example, H3K4me1 (a mark of enhancers) recruits chromatin remodelers that increase accessibility.

# Chromatin Accessibility is Dynamic
A major finding from recent years is that chromatin is not static—it's constantly moving and changing. Maeshima et al. (2012) used live-cell imaging to show that individual nucleosomes undergo local fluctuations (about 50 nanometers of movement in 30 milliseconds) due to Brownian motion. This constant jiggling means that even "closed" chromatin has moments when DNA becomes transiently accessible.
More surprisingly, Brancati et al. (2025) used an enzyme that methylates DNA to measure accessibility in living cells. They found that both euchromatin and heterochromatin are largely accessible in living human cells—only centromeric chromatin (which contains highly specialized structures) remains truly inaccessible. This challenges the old view that heterochromatin is completely closed off. Instead, chromatin accessibility appears to be about probability: how often and for how long is a given DNA sequence accessible?

# Why Does Accessibility Matter?
Chromatin accessibility is the first checkpoint for gene regulation. Before a gene can be transcribed, its regulatory elements (promoters and enhancers) need to be accessible to transcription factors. Inaccessible DNA simply cannot be bound by regulatory proteins, no matter how many transcription factors are present in the cell.
This means accessibility helps determine:

- **Cell identity**: Different cell types keep different genes accessible
- **Development**: Changes in accessibility drive differentiation
- **Disease**: Mutations that alter chromatin accessibility can cause disease
- **Response to signals**: Cells can change accessibility to respond to environmental cues

# Measuring Chromatin Accessibility
Scientists have developed several methods to map chromatin accessibility across the genome:
**DNase-seq** uses the enzyme DNase I, which preferentially cuts DNA in accessible regions. By sequencing the DNA fragments, researchers can map where chromatin is open
**FAIRE-seq** (Formaldehyde-Assisted Isolation of Regulatory Elements) uses the fact that nucleosome-free DNA is more easily extracted from formaldehyde-fixed chromatin.
**ATAC-seq** (Assay for Transposase-Accessible Chromatin), developed by *Buenrostro et al. (2013)*, uses a hyperactive Tn5 transposase enzyme that inserts DNA sequencing adapters into accessible chromatin. This method has become the most popular because it:
- Requires very few cells (as few as 500)
- Is fast (the protocol takes about 3 hours)
- Provides nucleosome positioning information in addition to accessibility
- Can be adapted to single-cell analysis

We'll dive into how ATAC-seq works and how to analyze ATAC-seq data in the next blog post.

# Accessibility and 3D Genome Organization
Recent work has shown that chromatin accessibility connects to 3D genome structure. Studies using Hi-C (which maps 3D contacts between different parts of the genome) found that boundaries between different chromatin domains often occur at highly accessible regions. This makes sense: accessible regions may be more flexible and able to form the loops and contacts that organize the genome in 3D space.

# Wrapping Up
Chromatin accessibility is a fundamental property that determines which parts of the genome are available for transcription factors to bind and genes to be expressed. It's controlled by multiple mechanisms including nucleosome positioning, chromatin remodeling, and histone modifications. Modern techniques like ATAC-seq allow us to map accessibility genome-wide with very few cells, opening up new ways to study gene regulation in development and disease.
In the next post, we'll get practical and walk through how to analyze ATAC-seq data to identify accessible chromatin regions in your own datasets.

# Key References
Foundational Work:
Kornberg, R. D. & Klug, A. The nucleosome. Sci. Am. 244, 52–64 (1981).
Luger, K. et al. Crystal structure of the nucleosome core particle at 2.8 Å resolution. Nature 389, 251–260 (1997).

Chromatin Accessibility:
Buenrostro, J. D. et al. Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, DNA-binding proteins and nucleosome position. Nat. Methods 10, 1213–1218 (2013).
Klemm, S. L., Shipony, Z. & Greenleaf, W. J. Chromatin accessibility and the regulatory epigenome. Nat. Rev. Genet. 20, 207–220 (2019).

Nucleosome Dynamics:
Maeshima, K. et al. Local nucleosome dynamics facilitate chromatin accessibility in living mammalian cells. Cell Rep. 2, 1645–1656 (2012).
Brancati, G. et al. Nucleosome dynamics render heterochromatin accessible in living human cells. Nat. Commun. 16, 4059 (2025).

Nucleosome Positioning:
Schones, D. E. et al. Dynamic regulation of nucleosome positioning in the human genome. Cell 132, 887–898 (2008).
Struhl, K. & Segal, E. Determinants of nucleosome positioning. Nat. Struct. Mol. Biol. 20, 267–273 (2013).

Reviews:
Buenrostro, J. D., Wu, B., Chang, H. Y. & Greenleaf, W. J. ATAC-seq: A method for assaying chromatin accessibility genome-wide. Curr. Protoc. Mol. Biol. 109, 21.29.1–21.29.9 (2015).
Henikoff, S. & Shilatifard, A. Histone modification: cause or cog? Trends Genet. 27, 389–396 (2011).

---
*Next up: ATAC-seq analysis from scratch—we'll take raw sequencing data and identify accessible chromatin regions step by step.*
