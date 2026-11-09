---
layout: page
title: RNA-seq Analysis
description: Notes on choosing and interpreting RNA-seq methods.
img: assets/img/rnaseq-intro.jpg
importance: 1
category: work
github: https://github.com/ipekselcen/rnaseq-tutorial
toc:
  sidebar: left
---

## Overview

These are notes I use when thinking through an RNA-seq analysis. The right workflow depends on the question and the experiment; there isn't one set of tools or read depth that fits every study.

## Start with the question

For a comparison of gene expression between conditions, gene-level counts may be enough. If the question is about isoforms or splicing, the analysis needs to retain transcript-level information. Those are related questions, but they are not answered by exactly the same processing steps.

Before choosing tools, I would check:

- What is the biological unit and how many independent biological replicates are there?
- Which conditions, batches, or other covariates belong in the design?
- Is the question about genes, transcripts, or splice events?
- What reference genome and annotation match the samples?

Biological replication is important because it lets us estimate variation between samples. More reads from the same sample do not replace independent replicates.

## From reads to counts

Quality checks can reveal issues with read quality, adapter content, library complexity, and alignment. They cannot establish that the samples were labeled correctly or that the experimental design answers the intended biological question.

For gene-level differential expression, the analysis usually starts with a raw count matrix and a design that reflects the experiment. Tools such as DESeq2 and edgeR model count data; normalization and statistical testing are part of those workflows. TPM and similar measures can be useful for describing or visualizing expression, but they are not substitutes for raw counts in those models.

Genome aligners such as STAR produce alignments that can be inspected in a genome browser. Transcript quantifiers such as Salmon estimate transcript abundance without requiring the same kind of genome-alignment output. The choice depends on the question and the downstream checks needed.

## Reading the results

Differential-expression results include both an estimate of change and a measure of statistical uncertainty. Adjusted p-values account for testing many genes; fold change describes the estimated size and direction of a difference. Neither one alone establishes biological importance.

Pathway enrichment can help summarize patterns in a gene list. It does not show that a pathway caused the observed changes. Results still need to be interpreted in the context of the experiment and, where needed, followed up with other evidence.

## Related work

- [Dnmt1 knockout RNA-seq project](/projects/2_project/): a reanalysis of public data that is still in progress.
- [RNA-seq tutorial repository]({{ page.github }}): the repository currently contains the early processing steps; the full analysis is not yet implemented.

These notes are a starting point, not a ready-made protocol. For a real study, check the dataset documentation and the current documentation for each tool.
