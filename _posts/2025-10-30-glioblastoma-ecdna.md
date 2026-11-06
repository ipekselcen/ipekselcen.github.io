---
layout: post
title: "Reading Glioblastoma ecDNA at Single-Cell Resolution"
date: 2025-10-30
description: What scCirclehunter can infer about ecDNA-bearing cell populations in glioblastoma from single-cell ATAC-seq data.
tags: ecDNA glioblastoma single-cell chromatin
categories: research-highlights
related_posts: true
---

Extrachromosomal DNA (ecDNA) consists of DNA circles separate from linear chromosomes. These circles can carry oncogenes and regulatory elements. Because ecDNA copy number can vary among tumor cells, it is one source of intratumoral heterogeneity. I wanted to understand how researchers can study that heterogeneity when the available data are single-cell chromatin accessibility profiles.

In a 2025 *Cell Discovery* paper, Jiang and colleagues introduce scCirclehunter, a computational framework that identifies candidate ecDNA regions from single-cell ATAC-seq data and assigns them to cell populations. The method uses a pseudo-bulk strategy and relies on assumptions about ecDNA copy number and chromatin accessibility. Its assignments are computational inferences from the sequencing data, not direct imaging of each circle in every cell.

## What the study reports

The authors applied scCirclehunter to glioblastoma datasets and reported variation in ecDNA-bearing cell populations across patients. In a tumor with multiple ecDNAs, they used the framework to examine malignant-cell trajectories associated with different ecDNA species.

They also integrated single-cell RNA-seq data and focused on ecNR2E1. Their analyses linked ecNR2E1-bearing cells with broader transcriptional programs, and the authors interpret the results as evidence that ecDNA can contribute to tumor progression. They additionally report a potential association between ecDNA and increased mitochondrial transfer. The latter is presented as a possible link, not proof that ecDNA-bearing cells cause mitochondrial transfer.

## What I took from it

The paper is a useful example of how an existing assay can support questions beyond its original readout. ATAC-seq measures accessible chromatin, but the authors use its signal patterns to infer candidate ecDNA and assign them to cell populations. That makes the method interesting for reanalysis of existing datasets, while also making validation and attention to its assumptions important.

I would be cautious about translating these results directly into clinical claims. The study offers a framework for investigating ecDNA-associated heterogeneity; it does not establish a biopsy strategy, a treatment, or a clinically validated way to select patients.

### References

1. Jiang R, et al. scCirclehunter delineates ecDNA-containing cells using single-cell ATAC-seq, with a focus on glioblastoma. *Cell Discovery.* 2025;11:98. [doi:10.1038/s41421-025-00842-9](https://doi.org/10.1038/s41421-025-00842-9)
2. Bailey C, Pich O, Thol K, et al. Origins and impact of extrachromosomal DNA. *Nature.* 2024;635:193-200.
