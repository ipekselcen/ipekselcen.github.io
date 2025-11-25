---
layout: default
title: "Chromatin Accessibility: Why Some DNA is Open for Business"
date: 2025-11-20
categories: editorial
tags: [chromatin, enhancer]
---

# Chromatin Accessibility: Why Some DNA is Open for Business

## Introduction

Your genome contains about 3 billion base pairs of DNA, all packed into a nucleus that's only about 5 micrometers across. If you stretched out all the DNA from one cell, it would be roughly 2 meters long. How does the cell pack all this DNA and still allow access to the genes that need to be read?

The answer is chromatin—the combination of DNA and proteins that makes up our chromosomes. But not all chromatin is packaged the same way. Some regions are tightly packed and inaccessible, while others are loosely organized and accessible. This accessibility determines which parts of the genome can be read by the cell's machinery. Understanding chromatin accessibility is fundamental to understanding how genes are regulated.

## Open vs. Closed Chromatin

DNA wraps around histone proteins to form nucleosomes—the basic units of chromatin. Each nucleosome consists of 147 base pairs of DNA wound 1.65 times around a histone octamer containing two copies each of H2A, H2B, H3, and H4 (Luger et al., 1997). These core histones are small, highly conserved proteins (11-15 kDa each) that are among the most abundant proteins in eukaryotic cells.

The DNA between nucleosomes, called linker DNA, varies in length from ~20-80 bp depending on the organism and genomic location. Histone H1 often binds to this linker DNA and helps compact nucleosomes into higher-order structures. When nucleosomes pack together tightly, they form closed chromatin (heterochromatin), which is generally transcriptionally inactive. When nucleosomes are spaced out or depleted, the DNA exists in open chromatin (euchromatin), which allows transcription factors and other regulatory proteins to bind.

This isn't just a binary on/off state. Chromatin exists along a spectrum from completely inaccessible to highly accessible. Different genomic regions have different levels of accessibility depending on:
- How many nucleosomes are present (nucleosome occupancy)
- How tightly nucleosomes are packed (spacing of 20 bp vs. 80 bp linkers)
- Which histone modifications are present (acetylation, methylation, phosphorylation)
- Whether the DNA is methylated (5-methylcytosine at CpG dinucleotides)
- Which chromatin remodeling enzymes are active
- The concentration and binding affinity of transcription factors competing for DNA access

Operationally, we measure accessibility by how easily enzymes like DNase I or Tn5 transposase can access the DNA. Highly accessible regions (like active promoters and enhancers) show 10-100 fold more enzyme cutting than bulk chromatin, while truly inaccessible regions (like centromeres) show very little cutting even with high enzyme concentrations.

## What Makes Chromatin Accessible?

Several mechanisms control whether chromatin is open or closed:

### Nucleosome Positioning and Depletion

The position of nucleosomes along DNA is not random. At active genes, the region immediately upstream of the transcription start site (TSS) often has few or no nucleosomes—this nucleosome-depleted region (NDR) is typically 100-200 bp wide and allows transcription factors to bind DNA directly. This NDR is flanked by well-positioned nucleosomes: the -1 nucleosome sits just upstream of the NDR, and the +1 nucleosome sits immediately downstream of the TSS.

Beyond the +1 nucleosome, you typically find a regular array of positioned nucleosomes (+2, +3, +4, etc.) with characteristic spacing of about 165-185 bp (nucleosome + linker). This phasing pattern gradually decays as you move further into the gene body (Schones et al., 2008). The precise positioning of these nucleosomes is controlled by a combination of DNA sequence preferences, transcription factor binding, and chromatin remodelers.

Segal et al. (2006) showed that DNA sequence itself has intrinsic preferences for nucleosome formation—certain sequences (particularly poly(dA:dT) tracts) disfavor nucleosome binding, while others with periodic AT/GC patterns stabilize nucleosomes. However, in living cells, these sequence preferences are often overridden by active processes involving ATP-dependent chromatin remodelers.

### Chromatin Remodeling Complexes

Cells use ATP-powered molecular machines called chromatin remodelers to move, eject, or restructure nucleosomes. These multi-subunit complexes consume ATP (typically 1 ATP per base pair translocated) to disrupt histone-DNA contacts and reposition nucleosomes. There are four main families, classified by their catalytic ATPase subunit:

- **SWI/SNF complexes** (including mammalian BAF and PBAF complexes) can slide nucleosomes along DNA or completely eject them. These complexes are typically 1-2 MDa in size and contain 10-15 subunits. The catalytic subunit (BRG1/SMARCA4 or BRM/SMARCA2) has both DNA translocation and histone chaperone activities, allowing these complexes to create NDRs at enhancers and promoters.

- **ISWI complexes** (SNF2H/SMARCA5 and SNF2L/SMARCA1 in mammals) typically slide nucleosomes to evenly space them, rather than ejecting them. They bind to both the nucleosome and linker DNA, using the length of linker DNA as a "ruler" to determine proper spacing. ISWI complexes are important for maintaining chromatin organization and generating the regular nucleosome arrays seen in gene bodies.

- **CHD complexes** (chromodomain helicase DNA-binding proteins) can both remodel nucleosomes and recognize specific histone modifications through their chromodomains. CHD1 recognizes H3K4me3 (a mark of active promoters), while CHD4 (part of the NuRD complex) is associated with gene repression.

- **INO80 complexes** specialize in nucleosome sliding and histone variant exchange. They can replace canonical H2A with the variant H2A.Z, which creates more unstable nucleosomes that are easier to displace.

### Histone Modifications

Chemical modifications on histone proteins affect how tightly DNA wraps around nucleosomes and which proteins can bind chromatin. Acetylation of lysine residues (particularly H3K27ac, H3K9ac, and H4K16ac) neutralizes the positive charge on histones, weakening the electrostatic interaction between histones and the negatively charged DNA backbone. This makes chromatin more accessible.

Histone acetyltransferases (HATs) like p300/CBP and GCN5 add acetyl groups, while histone deacetylases (HDACs) remove them. The balance between HAT and HDAC activity determines the acetylation state of chromatin. For example, p300 acetylates H3K27 at active enhancers, creating the H3K27ac mark that distinguishes active from poised regulatory elements.

Methylation has more complex effects depending on which residue is modified:
- **H3K4me1** marks enhancers (both active and poised)
- **H3K4me3** marks active promoters and the +1 nucleosome
- **H3K27me3** (deposited by Polycomb complexes) marks repressed chromatin
- **H3K9me3** and **H3K27me3** mark constitutive heterochromatin

These modifications don't just change DNA-histone affinity—they also create binding sites for "reader" proteins. For example, the bromodomains in SWI/SNF complexes recognize acetylated lysines, while chromodomains in CHD proteins recognize methylated lysines. This allows cells to couple histone modifications with chromatin remodeling.

## Chromatin Accessibility is Dynamic

A major finding from recent years is that chromatin is not static—it's constantly moving and changing. Maeshima et al. (2012) used fluorescence correlation spectroscopy and single-nucleosome imaging to show that individual nucleosomes undergo local fluctuations of approximately 50 nm over 30 millisecond timescales. This confined Brownian motion is driven by thermal energy and occurs even in densely packed mitotic chromosomes.

These dynamics have important implications: even DNA wrapped in a nucleosome can transiently unwrap from the histone octamer, exposing the DNA sequence for 10-250 milliseconds before rewrapping (Polach & Widom, 1995). This "breathing" means that transcription factors can access their binding sites even on nucleosomal DNA, though with lower probability than on nucleosome-free DNA.

More surprisingly, Brancati et al. (2025) used a DNA methyltransferase (M.EcoGII) to measure accessibility in living cells. This enzyme can only methylate accessible DNA and doesn't damage DNA like nucleases do. They found that both euchromatin and heterochromatin reach ~80-90% accessibility in living human cells—only centromeric α-satellite chromatin remains substantially inaccessible (~40% accessible). 

This challenges the traditional view that heterochromatin is completely closed off. Instead, chromatin accessibility appears to be about probability and kinetics: how often a given DNA sequence is accessible and for how long. Even in "closed" chromatin, DNA undergoes transient unwrapping that allows some transcription factor binding, though at much lower rates than in "open" chromatin.

## Why Does Accessibility Matter?

Chromatin accessibility is the first checkpoint for gene regulation. Before a gene can be transcribed, its regulatory elements (promoters and enhancers) need to be accessible to transcription factors. Inaccessible DNA simply cannot be bound by regulatory proteins, no matter how many transcription factors are present in the cell.

This means accessibility helps determine:
- **Cell identity**: Different cell types keep different genes accessible
- **Development**: Changes in accessibility drive differentiation
- **Disease**: Mutations that alter chromatin accessibility can cause disease
- **Response to signals**: Cells can change accessibility to respond to environmental cues

## Measuring Chromatin Accessibility

Scientists have developed several methods to map chromatin accessibility across the genome:

**DNase-seq** uses the enzyme DNase I (deoxyribonuclease I), which preferentially cuts DNA in accessible regions at a rate ~100-fold higher than in nucleosomal DNA. DNase I is a ~30 kDa endonuclease that requires Ca²⁺ and Mg²⁺ and cuts the DNA backbone non-specifically. By titrating DNase I concentration carefully, researchers can preferentially digest accessible DNA, then sequence the resulting fragments to map open chromatin genome-wide. DNase-seq typically requires 1-10 million cells and involves multiple optimization steps to get the right digestion conditions.

**FAIRE-seq** (Formaldehyde-Assisted Isolation of Regulatory Elements) exploits the fact that formaldehyde crosslinks proteins to DNA. After crosslinking and sonication, nucleosome-bound DNA remains in the crosslinked protein-DNA complexes and can be removed by phenol-chloroform extraction, while nucleosome-free DNA stays in the aqueous phase and can be sequenced. FAIRE-seq requires ~10 million cells.

**ATAC-seq** (Assay for Transposase-Accessible Chromatin), developed by Buenrostro et al. (2013), uses a hyperactive Tn5 transposase enzyme that simultaneously cuts DNA and inserts sequencing adapters (a process called "tagmentation"). The Tn5 transposase is a 50 kDa protein that, when loaded with adapter sequences, preferentially inserts into accessible chromatin. 

ATAC-seq has become the most popular method because it (Buenrostro et al., 2013, 2015):
- Requires very few cells (500-50,000, with recent protocols working from ~100 cells)
- Is fast (the wet lab protocol takes ~3 hours)
- Provides multiple types of information simultaneously: bulk accessibility, nucleosome positions (from fragment size distribution), and transcription factor footprints (from the pattern of Tn5 insertion sites)
- Can be adapted to single-cell analysis (scATAC-seq), allowing measurement of cell-to-cell variation in chromatin states
- Has high signal-to-noise ratio because the transposase only cuts accessible DNA

The fragment size distribution from ATAC-seq is particularly informative (Buenrostro et al., 2013): fragments <100 bp come from nucleosome-free regions, fragments of ~200 bp represent DNA from a single nucleosome (mono-nucleosomal), and larger fragments (400 bp, 600 bp) represent di-nucleosomes and tri-nucleosomes. This periodicity reveals nucleosome positioning genome-wide.

We'll dive deep into how ATAC-seq works and how to analyze ATAC-seq data computationally in the next blog post.

## Accessibility and 3D Genome Organization

Recent work has shown that chromatin accessibility connects to 3D genome structure. The genome is organized into topologically associating domains (TADs)—regions of 100 kb to several Mb that preferentially interact with themselves rather than neighboring regions (Dixon et al., 2012). Studies using Hi-C (which maps 3D contacts through proximity ligation) found that TAD boundaries are enriched for highly accessible chromatin, active genes, CTCF binding sites, and housekeeping genes.

Yellapu et al. (2024) showed that perturbing nucleosome positioning by deleting chromatin remodelers (ISW1, ISW2, and CHD1 in yeast) altered 3D chromatin organization. When nucleosomes were mispositioned, chromatin became more accessible at some regions and less accessible at others. This correlated with changes in short-range chromatin contacts (within ~5 kb) and weakening of larger chromatin domains. The data suggest that nucleosome positioning affects the physical stiffness of chromatin fibers, which in turn influences how easily DNA can loop and form contacts.

This makes sense mechanistically: accessible, nucleosome-depleted regions may be more flexible and able to form the loops and contacts that organize the genome in 3D space. The connection between accessibility and 3D structure is likely bidirectional—3D contacts can recruit chromatin remodelers that create accessible regions, and accessible regions facilitate the formation of certain 3D contacts.

## Wrapping Up

Chromatin accessibility is a fundamental property that determines which parts of the genome are available for transcription factors to bind and genes to be expressed. It's controlled by multiple mechanisms including nucleosome positioning, chromatin remodeling, and histone modifications. Modern techniques like ATAC-seq allow us to map accessibility genome-wide with very few cells, opening up new ways to study gene regulation in development and disease.

In the next post, we'll get practical and walk through how to analyze ATAC-seq data to identify accessible chromatin regions in your own datasets.

---

## Key References

**Foundational Work:**
- Kornberg, R. D. & Klug, A. The nucleosome. *Sci. Am.* 244, 52–64 (1981).
- Luger, K. et al. Crystal structure of the nucleosome core particle at 2.8 Å resolution. *Nature* 389, 251–260 (1997).

**Chromatin Accessibility:**
- Buenrostro, J. D. et al. Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, DNA-binding proteins and nucleosome position. *Nat. Methods* 10, 1213–1218 (2013).
- Buenrostro, J. D. et al. Single-cell chromatin accessibility reveals principles of regulatory variation. *Nature* 523, 486–490 (2015).
- Klemm, S. L., Shipony, Z. & Greenleaf, W. J. Chromatin accessibility and the regulatory epigenome. *Nat. Rev. Genet.* 20, 207–220 (2019).

**Nucleosome Dynamics:**
- Polach, K. J. & Widom, J. Mechanism of protein access to specific DNA sequences in chromatin: a dynamic equilibrium model for gene regulation. *J. Mol. Biol.* 254, 130–149 (1995).
- Maeshima, K. et al. Local nucleosome dynamics facilitate chromatin accessibility in living mammalian cells. *Cell Rep.* 2, 1645–1656 (2012).
- Brancati, G. et al. Nucleosome dynamics render heterochromatin accessible in living human cells. *Nat. Commun.* 16, 4059 (2025).

**Nucleosome Positioning:**
- Segal, E. et al. A genomic code for nucleosome positioning. *Nature* 442, 772–778 (2006).
- Schones, D. E. et al. Dynamic regulation of nucleosome positioning in the human genome. *Cell* 132, 887–898 (2008).
- Struhl, K. & Segal, E. Determinants of nucleosome positioning. *Nat. Struct. Mol. Biol.* 20, 267–273 (2013).

**3D Genome Organization:**
- Dixon, J. R. et al. Topological domains in mammalian genomes identified by analysis of chromatin interactions. *Nature* 485, 376–380 (2012).
- Yellapu, N. K. et al. Genome wide nucleosome landscape shapes 3D chromatin organization. *Sci. Adv.* 10, eadn2955 (2024).

**Reviews:**
- Buenrostro, J. D., Wu, B., Chang, H. Y. & Greenleaf, W. J. ATAC-seq: A method for assaying chromatin accessibility genome-wide. *Curr. Protoc. Mol. Biol.* 109, 21.29.1–21.29.9 (2015).
- Henikoff, S. & Shilatifard, A. Histone modification: cause or cog? *Trends Genet.* 27, 389–396 (2011).

---

*Next up: ATAC-seq analysis from scratch—we'll take raw sequencing data and identify accessible chromatin regions step by step.*
