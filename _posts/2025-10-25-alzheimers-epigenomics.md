---
layout: post
title: "Epigenomic Breakdown in Alzheimer's: When Brain Cells Lose Control"
date: 2025-10-25
description: How single-cell epigenomics reveals that Alzheimer's is fundamentally about regulatory collapse, not just protein aggregates
tags: epigenomics alzheimers single-cell chromatin research-summary
categories: research-highlights
related_posts: true
---

Most people think of Alzheimer's disease in terms of plaques and tangles; the protein clumps that show up in brain scans. But a massive new study published in *Cell* this September reveals that the real story might be about something more fundamental: brain cells losing their grip on gene regulation itself.

We've known for a while that Alzheimer's doesn't hit all brain regions equally. The hippocampus and entorhinal cortex (your memory centers) get hit early and hard, while other regions like the prefrontal cortex show damage later. But why? And at a cellular level, what's actually breaking down?

This is where single-cell epigenomics comes in. The epigenome (the chemical modifications that control which genes are accessible and which stay locked away) is essentially the instruction manual that tells each cell type how to be itself. When that manual gets corrupted, cells can't maintain their identity or function properly. Single-cell technologies have revolutionized our ability to map cellular diversity and regulatory landscapes in the brain, but applying them to understand disease progression at this scale is still relatively new.

## What They Did

The MIT and Broad Institute team, led by Manolis Kellis and Li-Huei Tsai, built the largest single-cell brain atlas for Alzheimer's to date. They profiled 3.5 million individual cells from 384 postmortem brain samples spanning six different brain regions in 111 donors from the Religious Orders Study and Rush Memory and Aging Project (two well-characterized longitudinal cohort studies that have been instrumental in Alzheimer's research).

The donors ranged from people with no pathology to early-stage and late-stage disease. The key innovation is the integration of single-nucleus ATAC-seq (measuring chromatin accessibility) and single-nucleus RNA-seq (measuring gene expression) in the same tissue samples. This lets you see not just which genes are being expressed, but whether the regulatory machinery controlling those genes is intact or falling apart.

## The Core Findings

Two major patterns emerged that fundamentally change how we think about Alzheimer's progression:

**First: Epigenome relaxation and compartment breakdown.** Healthy cells maintain strict spatial organization in their nuclei, with the genome partitioned into active and repressive compartments. Active compartments sit in the nuclear interior with accessible chromatin, while repressive compartments are near the nuclear periphery and lamina with higher A/T content.

In Alzheimer's, this organization breaks down. The cells experience what the authors call "epigenomic relaxation": regions that should be tightly closed become accessible, and active regions lose their structure. Vulnerable neurons in the entorhinal cortex and hippocampus showed the most dramatic compartment switching, with normally repressive chromatin becoming inappropriately activated.

**Second: Loss of epigenomic information.** Each cell type has a unique epigenetic signature that defines what it is. In Alzheimer's progression, cells lose this signature. They essentially forget how to be themselves. The study identified over 1 million candidate regulatory elements organized into 123 distinct modules across 67 cell subtypes, and tracked how these modules erode during disease.

The loss was most pronounced in excitatory neurons in superficial cortical layers, somatostatin-positive inhibitory interneurons, oligodendrocytes, and microglia.

Interestingly, glial cells showed a two-phase response. Early in disease, they gained epigenomic definition as they activated to respond to damage. But with sustained stress, they entered exhausted states and lost their epigenetic stability, especially pronounced in APOE4 carriers.

## The Resilience Angle

Here's the hopeful part: some people maintained cognitive function despite having significant Alzheimer's pathology in their brains. These "resilient" individuals showed something striking: their cells maintained higher epigenomic information across all brain regions compared to people who showed cognitive decline with similar pathology burdens. This suggests that preserving epigenetic stability might be protective, even when plaques and tangles are present.

This study shifts the therapeutic conversation. Instead of just targeting plaques and tangles (the end products of disease) we could potentially target the regulatory factors that maintain epigenomic stability. The authors point to Polycomb complexes, which act as "epigenomic guardians" by maintaining chromatin structure. Strengthening these systems, or targeting the specific transcription factors that regulate vulnerable cell types, could offer new intervention strategies.

The work complements a companion study published simultaneously in Cell, which found coordinated disruption of 3D genome organization alongside the epigenomic erosion described here. Together, these studies paint a comprehensive picture of how nuclear organization collapses in Alzheimer's.

The dataset itself is also a resource: all data is publicly available, giving the field a detailed molecular map of how different cell types in different brain regions respond to or resist Alzheimer's pathology.

## Technical Notes

The study used 10X Genomics platforms for both snATAC-seq (1.2 million nuclei) and snRNA-seq (2.3 million nuclei). They defined epigenomic compartments at genome-wide resolution using hidden Markov models, and calculated epigenomic information for single cells using Shannon entropy, quantifying how well cells maintain their cell-type-specific regulatory programs. Integration across regions and disease stages used Harmony for batch correction, with validation against ENCODE reference datasets.

> ##### TIP
>
> **Bottom Line:** Alzheimer's isn't just about protein aggregates. It's about a progressive loss of the regulatory control that keeps brain cells functioning. Understanding epigenomic erosion opens new therapeutic avenues and helps explain why some people are resilient while others aren't. This kind of comprehensive, multimodal atlas is exactly what the field needs to move beyond symptomatic treatments.
{: .block-tip }

**Paper:** Liu et al., *Cell* (2025) | [Read the paper →](https://doi.org/10.1016/j.cell.2025.06.031)

---

### References

- Kelsey G, Stegle O, Reik W. Single-cell epigenomics: Recording the past and predicting the future. *Science.* 2017;358(6359):69-75.
- Clark SJ, Lee HJ, Smallwood SA, Kelsey G, Reik W. Single-cell epigenomics: powerful new methods for understanding gene regulation and cell identity. *Genome Biol.* 2016;17:72.
- Bennett DA, Schneider JA, Arvanitakis Z, Wilson RS. Overview and findings from the religious orders study. *Curr Alzheimer Res.* 2012;9(6):628-645.
- Buenrostro JD, Giresi PG, Zaba LC, Chang HY, Greenleaf WJ. Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, DNA-binding proteins and nucleosome position. *Nat Methods.* 2013;10(12):1213-1218.
- Lieberman-Aiden E, van Berkum NL, Williams L, et al. Comprehensive mapping of long-range interactions reveals folding principles of the human genome. *Science.* 2009;326(5950):289-293.
- Dixon JR, Selvaraj S, Yue F, et al. Topological domains in mammalian genomes identified by analysis of chromatin interactions. *Nature.* 2012;485(7398):376-380.
- Arenaza-Urquijo EM, Vemuri P. Resistance vs resilience to Alzheimer disease: clarifying terminology for preclinical studies. *Neurology.* 2018;90(15):695-703.
- Mathys H, Boix CA, Akay LA, et al. Single-cell multiregion dissection of Alzheimer's disease. *Nature.* 2024;632:858-868.
- Korsunsky I, Millard N, Fan J, et al. Fast, sensitive and accurate integration of single-cell data with Harmony. *Nat Methods.* 2019;16(12):1289-1296.
