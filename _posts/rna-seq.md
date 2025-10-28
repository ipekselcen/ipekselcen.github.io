---
layout: post
title: "My First RNA-seq Analysis: What I Wish I'd Known"
date: 2025-10-28
categories: [bioinformatics]
tags: [rna-seq, R, excel]
---
If you've ever stared at an Excel file with 20,000 rows and thought "I have no idea if this is right anymore," this post is for you. Here's a confession: I once spent an entire afternoon trying to figure out if I'd accidentally shifted all my gene names off from their expression values. I hadn't. But I couldn't be sure. And that uncertainty—that sick feeling of "I think I broke something but I don't know what"—followed me through my first year of analyzing RNA-seq data. I spent that year working in Excel, and it was a special kind of torture. Let me tell you why I'll never go back—and how R saved my sanity.

Part 1: The Excel Nightmare (DRAFT)
The Sorting Disaster
My first RNA-seq dataset had 20,000 genes. I needed to sort by p-value to find my most significant hits. Simple, right?
I clicked the column header. Sorted. Done.
Except... wait. Did the gene names move with the p-values? Or did I just sort one column while the others stayed in place?
I scrolled to row 5,847. Checked if the gene name still matched its Ensembl ID. Looked right. Scrolled to row 12,933. Checked again. Seemed okay? I did this for twenty minutes, randomly spot-checking rows, never quite sure if I'd created a catastrophic misalignment somewhere in the 20,000 rows I wasn't checking.
This happened several times. Each time, the same paranoid checking ritual.
The Manual Editing Spiral
Then came the "cleaning" phase. My advisor wanted me to remove genes with NA values. So I started scrolling, manually deleting rows. Click. Delete. Click. Delete. My eyes glazed over around row 3,000.
Oh, and I removed all the Riken genes too. They don't code for proteins, right? (Spoiler: I was wrong about this, but I didn't know it at the time.) More manual deletion. More rows disappearing into the void with no record of what I'd removed or why.
The File Naming Catastrophe
Fast forward a few months. I'm comparing multiple RNA-seq datasets—neonatal OPCs vs. adult OPCs, control vs. TET2 deletion. Each comparison needed its own analysis. Each analysis spawned multiple Excel files:

DESeq2_results_final.xlsx
DESeq2_results_final_v2.xlsx
DESeq2_results_ACTUAL_final.xlsx
DESeq2_results_filtered_padj0.05.xlsx
DESeq2_comparison_adult_vs_neonatal_FINAL.xlsx

Each file had multiple sheets. Venn diagrams comparing overlaps. Color-coded cells. Conditional formatting that broke when I copied data between files.
I have at least 10 "final" versions of my analysis files sitting in folders right now. I look at them and genuinely don't remember what half of them are. What threshold did I use? Which comparison is this? Did I filter these before or after removing NAs?
The ultimate truth: I know I'll end up deleting most of them and redoing the analysis from scratch because I have no idea what past-me was thinking.
The Crushing Realization
The worst part? When my advisor asked: "Can you re-run this with padj < 0.01 instead of 0.05?"
My stomach dropped. That meant:

Opening the original file (which "original"?)
Manually filtering again
Re-creating all the downstream comparisons
Re-making all the Venn diagrams
Hoping I did it exactly the same way as before

It would take hours. And I still wouldn't be 100% sure I did it right.
