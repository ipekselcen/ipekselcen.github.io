---
layout: post
title: "Molecular Cloning: Hard-Won Lessons"
date: 2025-10-27
categories: [wetlab]
tags: [cloning, molecular-biology, protocols, troubleshooting]
---

After several cloning attempts this week, I've learned some valuable lessons the hard way. Here's what worked and what didn't.

## What Worked Well

### 1. Primer Design
- Used Primer3 for design
- Checked Tm carefully (within 2°C of each other)
- Added restriction sites with 4-6 bp overhangs
- BLAST checked for specificity

### 2. PCR Conditions
- Used high-fidelity polymerase (Q5)
- Gradient PCR to optimize Tm
- Always ran positive control

### 3. Verification
- Colony PCR before miniprep (saved so much time!)
- Sequencing both strands
- Checked insert orientation

## Common Mistakes I Made

### Mistake #1: Forgetting IPTG
Wasted two days because I forgot to add IPTG to the plates. The blue-white screening didn't work!

**Solution:** Now I have a checklist for plate preparation.

### Mistake #2: Wrong Antibiotic
Used ampicillin instead of kanamycin. Read the plasmid map more carefully!

### Mistake #3: Poor Ligation Ratios
Initially used 1:1 insert:vector. 

**Better:** 3:1 insert:vector ratio gave much better results.

## Current Success Rate

- Before: ~20% success
- Now: ~70% success

## Next Steps

- Try Gibson assembly
- Optimize transformation conditions
- Document full protocol

More detailed protocols coming soon!
