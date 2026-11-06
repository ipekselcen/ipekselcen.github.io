---
layout: post
title: "What Sequencing Methods Teach Us About Inference"
date: 2026-01-17
tags: epigenetics computational-thinking methods DNA-methylation chromatin
category: SciComm
related_posts: true
toc:
  sidebar: left
---

When I started learning computational biology, I thought of computation as something that happened after an experiment: sequence the sample, then analyze the data. Reading the history of sequencing methods changed that view. In methods such as bisulfite sequencing, the biological quantity of interest is not read directly. It has to be inferred from a measurement shaped by the chemistry and the assay.

That is a useful way to read methods papers: follow the steps from the molecular event to the signal, then from the signal to the biological claim.

## Bisulfite sequencing: a chemical conversion, then an inference

Frommer and colleagues introduced genomic sequencing with sodium bisulfite to map 5-methylcytosine at individual DNA strands.<sup>1</sup> Under bisulfite treatment, unmethylated cytosines are deaminated and read as thymines after amplification and sequencing, while 5-methylcytosines are relatively resistant and are generally read as cytosines.

The sequence is therefore an assay-dependent readout, not a direct label of methylation. At a cytosine position, a C in the treated read is interpreted as methylated and a T as converted, subject to conversion efficiency, sequencing error, coverage, and alignment. The result depends on both the chemical treatment and the computational steps used to map reads and summarize calls.

Standard bisulfite sequencing also does not distinguish 5-methylcytosine (5mC) from 5-hydroxymethylcytosine (5hmC): both are generally read as C. Methods such as oxidative bisulfite sequencing or TAB-seq were developed to distinguish these modifications.<sup>2,3</sup>

One detail I had not appreciated at first is that a measured conversion is not automatically a perfect classification. Incomplete conversion can make an unmethylated cytosine appear protected; damage or sequencing error can also affect calls. The assay's chemistry and quality controls are part of the interpretation, not merely preparation before “the real analysis.”

## ATAC-seq: more than peak locations

ATAC-seq uses Tn5 transposase to insert sequencing adapters into accessible chromatin.<sup>4</sup> The locations of insertions can be used to identify regions enriched for accessibility. The reads also retain fragment-length information, which can reflect nucleosome-associated patterns in the underlying chromatin.

That information needs careful interpretation. Fragment length is not a direct image of a nucleosome, and transcription-factor footprinting is sensitive to factors such as Tn5 sequence bias, coverage, and analysis choices. Methods such as NucleoATAC use fragment patterns to infer nucleosome positioning and occupancy; those inferences depend on the model and data quality.<sup>5</sup>

The broader lesson I take from ATAC-seq is to ask what information an assay records beyond its most familiar summary. A peak set is one representation of the data, not necessarily the only one. Additional analyses can be informative, but should be validated and described as inferences.

## ChIP-seq: modeling the data-generation process

ChIP-seq peak calling offers another example. Enriched read coverage is evidence for protein-associated DNA fragments, but coverage varies for reasons beyond binding. Peak callers therefore compare observed signal with a background model rather than treating every region with many reads as a binding site.

MACS was developed to identify enriched regions in ChIP-seq data using a model of fragment size and local background, with control data used when available.<sup>6</sup> The particular model and settings matter; a peak is a statistical call under those assumptions, not proof by itself that a protein directly binds a regulatory element or controls a nearby gene.

## The habit I am trying to build

These methods have helped me think of computational analysis as part of experimental reasoning. For any assay, I try to ask:

- What molecular property does the assay measure directly?
- What transformations occur between the sample and the data?
- Which parts of the result are measured, and which are inferred?
- What technical effects could produce a similar signal?
- What independent evidence would strengthen the interpretation?

This is not a checklist that guarantees a correct conclusion. It is a way to make the reasoning visible—from chemistry and read generation through analysis to interpretation. That has been a more useful introduction to computational thinking for me than the idea that it begins when a biologist opens a programming language.

### References

1. Frommer M, et al. A genomic sequencing protocol that yields a positive display of 5-methylcytosine residues in individual DNA strands. *Proc Natl Acad Sci U S A.* 1992;89(5):1827-1831. [doi:10.1073/pnas.89.5.1827](https://doi.org/10.1073/pnas.89.5.1827)
2. Booth MJ, et al. Quantitative sequencing of 5-methylcytosine and 5-hydroxymethylcytosine at single-base resolution. *Science.* 2012;336(6083):934-937. [doi:10.1126/science.1220671](https://doi.org/10.1126/science.1220671)
3. Yu M, et al. Base-resolution analysis of 5-hydroxymethylcytosine in the mammalian genome. *Cell.* 2012;149(6):1368-1380. [doi:10.1016/j.cell.2012.04.027](https://doi.org/10.1016/j.cell.2012.04.027)
4. Buenrostro JD, et al. Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, DNA-binding proteins and nucleosome position. *Nat Methods.* 2013;10(12):1213-1218. [doi:10.1038/nmeth.2688](https://doi.org/10.1038/nmeth.2688)
5. Schep AN, et al. Structured nucleosome fingerprints enable high-resolution mapping of chromatin architecture within regulatory regions. *Genome Res.* 2015;25(11):1757-1770. [doi:10.1101/gr.192294.115](https://doi.org/10.1101/gr.192294.115)
6. Zhang Y, et al. Model-based analysis of ChIP-Seq (MACS). *Genome Biol.* 2008;9(9):R137. [doi:10.1186/gb-2008-9-9-r137](https://doi.org/10.1186/gb-2008-9-9-r137)
