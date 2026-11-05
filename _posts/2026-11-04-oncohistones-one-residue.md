---
layout: post
title: "Oncohistones, part 1: the K27M mutation"
date: 2026-11-04
description: A single lysine-to-methionine swap in histone H3 can reprogram a cancer cell's entire epigenome.
tags: oncohistones H3K27M glioma chromatin epigenetics PRC2
categories: research-highlights
related_posts: true
toc:
  sidebar: left
---

This is the first in a set of posts working through the biology of oncohistones. The topic connects to the question I studied in my PhD, how cells hold or lose a chromatin state, so I'm writing up each piece as I read into it. K27M is where the field began, so it comes first.

## What an oncohistone is

An oncohistone is a mutation in a histone gene that drives cancer. It is a striking idea for two reasons. First, a tumour cell carries many copies of the histone genes, so a single mutant allele is only a small fraction of the total histone pool, yet it is enough to change chromatin across the whole genome. Second, the mutation is in the histone itself, the surface that modifications are written on, rather than in the enzyme that writes them. Most cancer drivers are enzymes or tumour suppressors; here the substrate is the driver.

The first oncohistones were found in 2012, in pediatric brain tumours. Wu and colleagues found a lysine-27-to-methionine change (K27M) in the histone H3 gene in 78% of diffuse intrinsic pontine gliomas (DIPGs) and 22% of other pediatric high-grade gliomas.<sup>2</sup> Schwartzentruber and colleagues found the same mutation, along with a second one at position 34, in a separate cohort.<sup>1</sup>

## What K27M does

Lysine 27 on histone H3 carries H3K27me3, a mark that keeps developmental genes switched off. The enzyme that writes it is PRC2, through its subunit EZH2. When that lysine is replaced by a methionine, the mutant tail fits into EZH2 and jams it.<sup>3</sup>

The early account was simply that the mutant blocks the enzyme and the mark disappears, but the mechanism is more specific. K27M does not stop PRC2 from reaching chromatin. It stops the mark from spreading. H3K27me3 does not fall to zero; it collapses back to the small number of sites, the CpG islands, where PRC2 binds most tightly and holds on.<sup>5</sup> That residual pattern, together with DNA hypomethylation, is what changes which genes are expressed.<sup>4</sup>

## Why the tumour still needs PRC2

K27M cripples PRC2 across the genome, but the tumour cells still depend on the activity that remains, and blocking EZH2 slows their growth.<sup>6</sup> A mutation that breaks the enzyme genome-wide leaves the cell reliant on the enzyme's leftover function. That dependency is now a drug target: in 2025 the FDA gave accelerated approval to dordaviprone for recurrent K27M diffuse midline glioma, the first systemic drug for the disease, on a 22% response rate.<sup>7</sup>

## The cell it happens in

A genome-wide loss of repression could in principle do anything, so what makes these tumours specific is the cell the mutation lands in. Single-cell RNA-seq of K27M gliomas showed that most of the dividing cells resemble oligodendrocyte precursor cells (OPCs).<sup>8</sup> The mutation holds the cell in a precursor state rather than letting it mature, and that OPC-like population is the one that drives the tumour.

## Open questions

The shape of it: one residue, a jammed enzyme, a mark that retreats rather than vanishes, and a cell held as a precursor. The next posts look at the G34 mutation, which sits next to K27 but works differently, and at whether these tumours buffer the disruption or simply tolerate it.

---

### References

1. Schwartzentruber J, et al. Driver mutations in histone H3.3 and chromatin remodelling genes in paediatric glioblastoma. *Nature*. 2012;482(7384):226-231.
2. Wu G, et al. Somatic histone H3 alterations in pediatric diffuse intrinsic pontine gliomas and non-brainstem glioblastomas. *Nat Genet*. 2012;44(3):251-253.
3. Lewis PW, et al. Inhibition of PRC2 activity by a gain-of-function H3 mutation found in pediatric glioblastoma. *Science*. 2013;340(6134):857-861.
4. Bender S, et al. Reduced H3K27me3 and DNA hypomethylation are major drivers of gene expression in K27M mutant pediatric high-grade gliomas. *Cancer Cell*. 2013;24(5):660-672.
5. Harutyunyan AS, et al. H3K27M induces defective chromatin spread of PRC2-mediated repressive H3K27me2/me3 and is essential for glioma tumorigenesis. *Nat Commun*. 2019;10(1):1262.
6. Mohammad F, et al. EZH2 is a potential therapeutic target for H3K27M-mutant pediatric gliomas. *Nat Med*. 2017;23(4):483-492.
7. U.S. FDA grants accelerated approval to dordaviprone (Modeyso) for recurrent H3 K27M-mutant diffuse midline glioma, 2025. [National Brain Tumor Society announcement](https://braintumor.org/news/first-treatment-approved-for-rare-pediatric-and-adult-brain-tumor-type-fda-grants-accelerated-approval-to-dordaviprone-modeyso/).
8. Filbin MG, et al. Developmental and oncogenic programs in H3K27M gliomas dissected by single-cell RNA-seq. *Science*. 2018;360(6386):331-335.
