---
layout: page
title: H4K8ac ChIP-seq Analysis
description: H4K8ac ChIP-seq in adult and neonatal oligodendrocyte progenitor cells.
img: assets/img/chipseq-project.jpg
importance: 3
category: work
github: https://github.com/ipekselcen/chipseq-tutorial
toc:
  sidebar: left
---

## Overview

This page is about our study of histone H4 lysine 8 acetylation (H4K8ac) in adult and neonatal oligodendrocyte progenitor cells (OPCs). I was a co-first author on the paper.

The study used histone proteomics and ChIP-seq on sorted OPCs. H4K8ac was enriched in adult OPCs, including at regions associated with progenitor, metabolic, and myelin-related genes. Adult OPCs also had higher expression of lipid-metabolism and myelin-related transcripts, and lower expression of cell-cycle and proliferation-related transcripts. In the study, pharmacological inhibition of histone acetylation reduced expression of H4K8ac target genes and reduced adult OPC proliferation.

These results connect H4K8ac with differences between adult and neonatal OPCs. ChIP-seq shows where the mark is enriched; the perturbation experiments provide additional evidence about its relationship to gene expression and proliferation.

## Paper and data

- Dansu DK, Selcen I, et al. (2024). “Histone H4 acetylation differentially modulates proliferation in adult oligodendrocyte progenitors.” *Journal of Cell Biology* 223(11):e202308064. [doi:10.1083/jcb.202308064](https://doi.org/10.1083/jcb.202308064)
- [GEO: GSE263808](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE263808)

## Analysis code

The [ChIP-seq repository]({{ page.github }}) is a separate, unfinished workflow based on the study. It is not ready to reproduce the paper as written: the download script still has placeholder SRA accessions, and `run_all.sh` expects scripts in a `scripts/` directory, while the scripts currently live in the repository root.

I am keeping the paper's findings separate from this code until the sample metadata and analysis steps have been checked and the workflow can be run and compared with the published results.
