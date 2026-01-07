---
layout: post
title: "Tracking Glioblastoma's Circular DNA at Single-Cell Resolution"
date: 2025-10-30
description: How single-cell epigenomics reveals that Alzheimer's is fundamentally about regulatory collapse, not just protein aggregates
tags: circular DNA glioblastoma single-cell chromatin research-highlights
categories: research-highlights
related_posts: true
---

Glioblastoma is the most lethal brain cancer we know, with a median survival under two years even with aggressive treatment. One reason it's so hard to treat is extrachromosomal DNA, which are circular DNA molecules that carry amplified oncogenes and exist outside the normal chromosomes.

## The ecDNA Problem
Extrachromosomal DNA, or ecDNA, shows up in about 50-60% of glioblastomas, making it one of the most ecDNA-rich cancers. These circular DNA molecules typically carry oncogenes such as EGFR, PDGFRA, and CDK4, which are all drivers of aggressive tumor growth. What makes ecDNA particularly dangerous is how it behaves during cell division. Unlike chromosomal DNA, which gets precisely copied and distributed to daughter cells, ecDNA segregates randomly. One daughter cell might inherit many copies while another gets few or none, creating massive cell-to-cell variation in oncogene dosage. This heterogeneity fuels drug resistance and tumor evolution.

The problem is that most ecDNA studies have relied on bulk sequencing or imaging approaches that average across thousands of cells, missing this critical heterogeneity. We've needed a way to track ecDNA at single-cell resolution in patient samples.

## What They Did
A team from Soochow University developed scCirclehunter, a computational framework specifically designed to identify ecDNA from single-cell ATAC-seq data. The clever part is how they exploit chromatin accessibility patterns. EcDNA regions show distinctive accessibility signatures because they exist as circles rather than being packed into chromatin like chromosomal DNA. The method uses a pseudo-bulk strategy to first identify candidate ecDNA regions across all cells, then assigns these ecDNAs to specific cell populations using statistical modeling.

They applied scCirclehunter to existing glioblastoma scATAC-seq datasets and showed it could reliably detect ecDNA and determine which individual cells carry it. This matters because it finally lets you ask: which tumor cells have ecDNA? How many copies? And what are those cells doing differently?

## Key Findings
    
The analysis revealed striking inter-patient and intra-tumor heterogeneity. Across different glioblastoma patients, ecDNA-carrying cells showed distinct distributions. Some patients had ecDNA throughout most of their tumor, while others showed more patchy distributions. Within a single patient harboring multiple different ecDNAs, they could track separate malignant cell trajectories associated with each ecDNA species.
Focusing on ecNR2E1 (an ecDNA carrying the NR2E1 oncogene), they integrated the chromatin accessibility data with matched single-cell RNA-seq to understand how ecDNA affects cellular behavior. The ecDNA didn't just amplify NR2E1 expression—it drove broader transcriptional programs associated with tumor aggressiveness. Cells carrying ecNR2E1 showed activation of pathways involved in cell proliferation, survival, and immune evasion.
An unexpected finding emerged around mitochondrial dynamics. Cells with ecDNA showed evidence of increased mitochondrial transfer, which is a process where cells exchange mitochondria with neighbors. This suggests ecDNA-carrying cells might be manipulating their local environment in ways beyond just overexpressing oncogenes.

## Why This Matters

This work provides a generalizable approach for studying ecDNA heterogeneity in any cancer where scATAC-seq data exists. The single-cell resolution matters clinically because it reveals that ecDNA distribution isn't uniform: some regions of a tumor might be ecDNA-heavy while others aren't. This has implications for biopsy sampling, where a single needle biopsy might miss or oversample ecDNA-positive regions, and for understanding why tumors respond heterogeneously to treatment.

From a therapeutic standpoint, knowing which cells carry ecDNA and what those cells are doing opens new targeting strategies. Rather than just going after the oncogene itself (such as EGFR inhibitors that often fail in ecDNA-positive tumors), you could potentially target the unique vulnerabilities of ecDNA-carrying cells or the mechanisms that maintain ecDNA.

> ##### WARNING
>
> The broader point is methodological: chromatin accessibility data, which many researchers are already generating, contains information about structural genomic alterations like ecDNA that we haven't been systematically extracting. scCirclehunter provides a way to mine existing datasets for insights into tumor heterogeneity that would otherwise remain hidden.
{: .block-warning }

> ##### TIP
>
> **Bottom Line:** Glioblastoma's circular DNA drives heterogeneity and treatment resistance, but we've lacked tools to track it cell-by-cell in patients. Single-cell chromatin accessibility provides a window into which cells carry ecDNA and how that shapes tumor behavior. As ecDNA-targeted therapies move toward the clinic, understanding its distribution at single-cell resolution will be critical for rational treatment design.
{: .block-tip }

**Paper:**  Jiang et al., *Cell Discovery* (2024) | [Read the paper →](https://www.nature.com/articles/s41421-025-00842-9)


### References

1. Kim H, Nguyen NP, Turner K, et al. Extrachromosomal DNA is associated with oncogene amplification and poor outcome across multiple cancers. Nat Genet. 2020;52:891-897.
2. Bailey C, Pich O, Thol K, et al. Origins and impact of extrachromosomal DNA. Nature. 2024;635:193-200.
3. Lange JT, Rose JC, Chen CY, et al. The evolutionary dynamics of extrachromosomal DNA in human cancers. Nat Genet. 2022;54:1527-1533.
4. Nathanson DA, Gini B, Mottahedeh J, et al. Targeted therapy resistance mediated by dynamic regulation of extrachromosomal mutant EGFR DNA. Science. 2014;343:72-76.