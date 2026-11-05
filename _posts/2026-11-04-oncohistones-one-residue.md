---
layout: post
title: "Oncohistones, part 1: the K27M mutation"
date: 2026-11-04
description: A single lysine-to-methionine swap in histone H3 can reshape chromatin and gene expression across a cancer cell.
tags: oncohistones H3K27M glioma chromatin epigenetics PRC2
categories: research-highlights
related_posts: true
toc:
  sidebar: left
---

This is the first in a set of posts working through the biology of oncohistones. The topic connects to the question I studied in my PhD, how cells hold or lose a chromatin state, so I'm writing up each piece as I read into it. K27M is where the field began, so it comes first.

## What an oncohistone is

An oncohistone is a mutation in a histone gene that contributes to cancer. It is a striking idea for two reasons. First, mutant H3 makes up only a minority of the histone H3 pool, yet H3K27M can alter chromatin across the genome. Second, the mutation is in the histone itself, the surface that modifications are written on, rather than in the enzyme that writes them. Many cancer drivers affect enzymes or tumour suppressors; here, the substrate itself is altered.

Oncohistone mutations came to prominence in 2012 through reports in pediatric brain tumors. In their cohort, Wu and colleagues found a lysine-27-to-methionine change (K27M) in 78% of diffuse intrinsic pontine gliomas (DIPGs) and 22% of non-brainstem pediatric glioblastomas.<sup>2</sup> In a separate cohort, Schwartzentruber and colleagues reported H3.3 K27M as well as mutations at position 34 (G34R/V).<sup>1</sup>

## What K27M does

Lysine 27 on histone H3 can carry H3K27me3, a repressive mark associated with silencing developmental genes. PRC2 writes this mark through its catalytic subunit, EZH2. K27M-containing histone binds EZH2 and inhibits PRC2 methyltransferase activity.<sup>3</sup>

The effect is not simply that PRC2 can no longer bind chromatin. K27M disrupts the broad spreading of PRC2-mediated H3K27 methylation. H3K27me3 is greatly reduced genome-wide, but can persist at specific loci, including CpG-island-associated sites.<sup>5</sup> Reduced H3K27me3 and DNA hypomethylation contribute to altered gene-expression programs in these tumors.<sup>4</sup>

## Why the tumour still needs PRC2

K27M broadly suppresses PRC2 activity, but residual EZH2 activity can still support tumor growth in preclinical models; inhibiting EZH2 slowed growth in those studies.<sup>6</sup> This suggested a potential therapeutic vulnerability, but it is not the mechanism of dordaviprone. In 2025, the FDA granted accelerated approval to dordaviprone for adults and children aged 1 year and older with H3 K27M-mutant diffuse midline glioma that has progressed after prior therapy. This was the first FDA approval of a systemic therapy for this tumor type. In the FDA efficacy population of 50 patients, the objective response rate was 22%.<sup>7</sup>

## The cell it happens in

A genome-wide loss of repression could in principle affect many cell programs, so cellular context matters. Single-cell RNA-seq of K27M gliomas identified several malignant cell states, including an oligodendrocyte precursor cell-like (OPC-like) state that was highly proliferative.<sup>8</sup> The tumor is therefore better described as a collection of cell states than as one precursor population; the OPC-like compartment is particularly proliferative and may contribute to tumor growth.

## Open questions

The shape of it: one residue, an inhibited enzyme, a mark that is depleted but persists at some loci, and several tumor cell states. The next posts look at the G34 mutation, which sits next to K27 but works differently, and at whether these tumors buffer the disruption or simply tolerate it.

---

### References

1. Schwartzentruber J, et al. Driver mutations in histone H3.3 and chromatin remodelling genes in paediatric glioblastoma. *Nature*. 2012;482(7384):226-231.
2. Wu G, et al. Somatic histone H3 alterations in pediatric diffuse intrinsic pontine gliomas and non-brainstem glioblastomas. *Nat Genet*. 2012;44(3):251-253.
3. Lewis PW, et al. Inhibition of PRC2 activity by a gain-of-function H3 mutation found in pediatric glioblastoma. *Science*. 2013;340(6134):857-861.
4. Bender S, et al. Reduced H3K27me3 and DNA hypomethylation are major drivers of gene expression in K27M mutant pediatric high-grade gliomas. *Cancer Cell*. 2013;24(5):660-672.
5. Harutyunyan AS, et al. H3K27M induces defective chromatin spread of PRC2-mediated repressive H3K27me2/me3 and is essential for glioma tumorigenesis. *Nat Commun*. 2019;10(1):1262.
6. Mohammad F, et al. EZH2 is a potential therapeutic target for H3K27M-mutant pediatric gliomas. *Nat Med*. 2017;23(4):483-492.
7. U.S. Food and Drug Administration. FDA grants accelerated approval to dordaviprone for diffuse midline glioma. 2025. [FDA announcement](https://www.fda.gov/drugs/resources-information-approved-drugs/fda-grants-accelerated-approval-dordaviprone-diffuse-midline-glioma).
8. Filbin MG, et al. Developmental and oncogenic programs in H3K27M gliomas dissected by single-cell RNA-seq. *Science*. 2018;360(6386):331-335.
