---
layout: post
title: "Learning to Think Beyond a Linear TET Pathway"
date: 2026-01-02
description: A reflection on how the published TET literature changed the way I think about DNA methylation and gene regulation.
tags: systems-biology computational-thinking epigenetics DNA-methylation
categories: SciComm
related_posts: true
toc:
  sidebar: left
---

I first learned DNA methylation through a tidy set of arrows: 5-methylcytosine (5mC) is added to DNA, TET enzymes oxidize it, and further processing can contribute to demethylation. That outline is useful, but it left me thinking about methylation as a switch and the TET enzymes as interchangeable parts.

Reading the early TET literature made that picture harder to hold. The original biochemical work showed that TET1 can convert 5mC to 5-hydroxymethylcytosine (5hmC).<sup>1</sup> Later studies showed that TET proteins can further oxidize 5mC to 5-formylcytosine (5fC) and 5-carboxylcytosine (5caC); 5caC can be excised by thymine DNA glycosylase (TDG), providing a route toward DNA demethylation.<sup>2,3</sup> These findings describe biochemical possibilities; they do not mean every modified cytosine passes through every state in the same way, in every cell.

## What does 5hmC tell us?

I used to think of 5hmC mainly as an intermediate on the way to demethylation. That remains one possible interpretation, but it is not the only one. Studies in mouse embryonic stem cells reported that TET1 and TET2 contribute to 5hmC production and linked 5hmC with pluripotency and lineage specification.<sup>4</sup>

The presence of 5hmC alone does not tell us whether it is transient, relatively stable, or associated with a particular regulatory outcome. Those interpretations depend on context and on what is measured. The point that changed my thinking was narrower: a mark detected in a sample should not automatically be assigned a single function from the pathway diagram alone.

This also made me more careful with the familiar shorthand that methylated DNA is “off” and unmethylated DNA is “on.” DNA methylation can be associated with transcriptional repression, but expression depends on genomic location and other regulatory factors. A methylation measurement, by itself, is not a complete readout of gene activity.

## Similar enzymes, distinct contexts

The three TET enzymes share catalytic activities, but that does not make them interchangeable in every biological setting. Their expression patterns and functions can vary by cell type and developmental context.<sup>4,5</sup> A phenotype following loss of one enzyme also cannot, by itself, tell us whether another enzyme compensated.

For example, a TET1 knockout study reported that loss of Tet1 was compatible with embryonic and postnatal development in mice, while also documenting phenotypes.<sup>5</sup> I had initially read results like this as evidence of redundancy. The more careful interpretation is that the organism can develop without TET1 under the conditions studied; identifying why requires additional evidence. Compensation is one possibility, not a conclusion supplied by viability alone.

## A different way to read a pathway

The change for me was not abandoning pathway diagrams, but treating them as starting points. When I read a paper or think through an experiment, I try to separate the biochemical step from the cellular outcome:

- What reaction is directly established?
- Where and in which cell type was it measured?
- Is the proposed effect on gene expression measured, or inferred?
- What other mechanisms could explain the observation?

These questions are part of what I mean by computational thinking. They do not require a computer; they require making assumptions visible and asking whether the available evidence distinguishes between explanations.

I am still learning how to apply this way of thinking across epigenetic measurements and how to communicate uncertainty without obscuring the result. For me, the most useful habit has been to say precisely what a study shows, what it suggests, and what remains open. A pathway diagram can orient the question. It cannot replace the evidence needed to answer it.

---

### References

1. Tahiliani M, et al. (2009) ["Conversion of 5-methylcytosine to 5-hydroxymethylcytosine in mammalian DNA by MLL partner TET1."](https://doi.org/10.1126/science.1170116) *Science* 324(5929):930-5.

2. Ito S, et al. (2011) ["Tet proteins can convert 5-methylcytosine to 5-formylcytosine and 5-carboxylcytosine."](https://doi.org/10.1126/science.1210597) *Science* 333(6047):1300-3.

3. He YF, et al. (2011) ["Tet-mediated formation of 5-carboxylcytosine and its excision by TDG in mammalian DNA."](https://doi.org/10.1126/science.1210944) *Science* 333(6047):1303-7.

4. Koh KP, et al. (2011) ["Tet1 and Tet2 regulate 5-hydroxymethylcytosine production and cell lineage specification in mouse embryonic stem cells."](https://doi.org/10.1016/j.stem.2011.01.008) *Cell Stem Cell* 8(2):200-13.

5. Dawlaty MM, et al. (2011) ["Tet1 is dispensable for maintaining pluripotency and its loss is compatible with embryonic and postnatal development."](https://doi.org/10.1016/j.stem.2011.07.010) *Cell Stem Cell* 9(2):166-75.
