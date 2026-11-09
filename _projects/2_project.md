---
layout: page
title: Dnmt1 Knockout Analysis
description: RNA-seq analysis of public Dnmt1 knockout data from neonatal OPCs.
img: assets/img/dnmt1-project.jpg
importance: 2
category: work
github: https://github.com/ipekselcen/rnaseq-tutorial
toc:
  sidebar: left
---

## Overview

I am working with the public RNA-seq dataset GSE79018, which compares neonatal mouse oligodendrocyte progenitor cells with *Dnmt1* knockout and control samples. DNMT1 helps maintain DNA methylation through cell division. The question I want to explore is how gene expression differs between the two groups.

This reanalysis is not finished, so I am not presenting differential-expression or pathway results here.

## What is in the repository

The [RNA-seq repository]({{ page.github }}) currently contains scripts for downloading the data, quality control, adapter trimming, alignment, and gene counting. The differential-expression and pathway-analysis scripts referenced by the pipeline runner are not present yet, so it does not run end to end.

Before interpreting results, I also need to verify the sample-to-condition mapping against the GEO records and check the analysis steps and outputs. Until then, numbers or biological explanations would be premature.

## Dataset and source

- [GEO: GSE79018](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE79018)
- Moyon et al. (2016). “Functional Characterization of DNA Methylation in the Oligodendrocyte Lineage.” *Cell Reports*. [doi:10.1016/j.celrep.2016.03.060](https://doi.org/10.1016/j.celrep.2016.03.060)

The paper provides the biological context for the dataset. This project is a computational reanalysis, not a report of new experimental results.
