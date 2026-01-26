---
layout: post
title: "The Method That Taught Biologists to Code (Without Knowing It)"
date: 2026-01-17
tags: epigenetics, computational-thinking, methods, DNA-methylation, chromatin
category: research-highlights
related_posts: true
toc:
  sidebar: left
---

> **For the biologist who learned to code out of necessity:** This post traces how three experimental breakthroughs in epigenetics inadvertently taught us computational thinking—before we even knew we were learning it.

## The Problem That Changed Everything

**1992, UC San Francisco.** Marianne Frommer faced what seemed like an impossible question: how do you tell the difference between a methylated cytosine and an unmethylated one?

Both are cytosines. Both look identical under a microscope. Both have the same mass on a spectrometer. The only difference—one has a methyl group (-CH₃), the other doesn't—is chemically silent in most assays.

Her solution seemed almost comically simple: treat DNA with sodium bisulfite. Under harsh conditions (high temperature, low pH, hours of incubation), something remarkable happens. Unmethylated cytosines convert to uracils. Methylated cytosines stay cytosines, as the methyl group protects them.

Sequence the treated DNA, and you get your answer. Except you don't get a direct readout of methylation. You get sequences full of Ts (converted from unmethylated Cs) and Cs (that stayed methylated because they were protected). Someone, or something, has to infer the original methylation state by comparing treated to untreated DNA.

> **The moment Frommer created bisulfite sequencing, she created a computational problem.**

That inference step? That's **decomposition**—the first principle of computational thinking. Breaking down a complex biological question ("What's methylated?") into a series of logical steps that must be executed in order.

---

## What Bisulfite Sequencing Actually Forced You to Do

Let's unpack what running bisulfite sequencing required in those early days. This is computational thinking emerging in real time:

**The experimental question:** "What is the methylation status of my genomic region?"

**The computational breakdown:**

1. Sequence both bisulfite-treated and untreated DNA
2. Align bisulfite-converted reads to a reference genome (but the reads don't match perfectly anymore because C→T conversions make them different)
3. For every cytosine in the reference, ask: did it stay C (methylated) or become T (unmethylated)?
4. Calculate methylation percentage per site across multiple reads
5. Account for incomplete conversion (some Cs don't convert even if unmethylated—your bisulfite kit isn't perfect)
6. Account for sequencing errors (some Ts might be sequencing mistakes, not conversions)

**Each of these is its own computational problem.** And here's what's fascinating: in the 1990s and early 2000s, biologists did steps 3-6 *by hand*, often using Excel. They were doing computational thinking without formal training. They just called it "analyzing my data."

> ##### Editorial Note: What Made This a Methods Paper
>
> Frommer et al. (1992) in *PNAS* is a masterclass in methods innovation. The paper:
- **Identified a chemical property** (differential deamination) that could encode biological information
- **Validated the method** on known methylated sites (CG islands)
- **Demonstrated generalizability** across different genomic contexts
- **Acknowledged limitations** (incomplete conversion, sequencing requirements)

**Why this matters for Nature Methods readers:** The best methods papers don't just describe a new technique. They show how the technique enables questions that were previously unanswerable. Frommer's innovation wasn't just measuring methylation—it was measuring methylation *at single-nucleotide resolution*.

The computational burden this created? That was a feature, not a bug. It forced the field to develop tools that would become essential for all sequencing-based methods.

**Reference:** Frommer, M. et al. (1992). "A genomic sequencing protocol that yields a positive display of 5-methylcytosine residues in individual DNA strands." *PNAS* 89(5):1827-1831.
{: .block-tip }

## The Pattern Recognition Breakthrough: ATAC-seq's Hidden Data

Fast forward to 2013. Jason Buenrostro, a graduate student in Bill Greenleaf's lab at Stanford, developed ATAC-seq (Assay for Transposase-Accessible Chromatin using sequencing).

The experimental approach is elegantly simple: a hyperactive transposase (Tn5) simultaneously cuts DNA at accessible regions and inserts sequencing adapters. No crosslinking, no sonication, no antibodies. Just Tn5, some cells, and a sequencer.

Sequence the fragments. Count where they came from. You have a map of open chromatin.

**Except that's not all you have.**

### The Data Everyone Ignored (At First)

Here's what early ATAC-seq papers did:
1. Align reads to the genome
2. Call peaks where reads pile up
3. Conclude: "This region is accessible"
4. Discard everything else

But "everything else" included fragment length. And fragment length turned out to encode an enormous amount of information that was sitting there all along.

Think about what Tn5 actually does: it cuts accessible DNA. But DNA isn't naked—it's wrapped around nucleosomes. Tn5 cuts in the linker regions between nucleosomes, or in nucleosome-free regions at regulatory elements.

- **Fragments ~40-50 bp:** Tn5 cut on both sides of a transcription factor or other protein. Nucleosome-free region.
- **Fragments ~200 bp:** Tn5 cut in flanking linkers around one nucleosome. Mononucleosome.
- **Fragments ~400 bp:** Two nucleosomes with linker. Dinucleosome.

**This is pattern recognition:** seeing signal in what everyone else thought was noise.

> ##### Editorial Note: When Simple Gets Sophisticated
>
> Buenrostro et al. (2013) in *Nature Methods* appeared straightforward: replace DNase-seq's complex protocol with Tn5 tagmentation. But the method's real innovation emerged later, as the field recognized patterns in the data.

**Evolution of ATAC-seq analysis:**

- **2013:** Peak calling only
- **2015:** Fragment length distributions reveal nucleosome positioning
- **2016:** NucleoATAC extracts transcription factor footprints
- **2019:** Single-cell ATAC-seq with droplet microfluidics
- **2023:** Paired-tag methods for chromatin + RNA in same cells

**What this teaches about methods evaluation:** The best methods create data that the developers didn't fully know how to interpret yet. ATAC-seq's fragment lengths were always there. It took the field 2-3 years to systematically recognize the patterns.

**When reviewing methods papers, ask:** Is the data richer than the analysis shown? Are there unexploited features that could enable future discoveries?

**Reference:** Buenrostro, J.D. et al. (2013). "Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, DNA-binding proteins and nucleosome position." *Nature Methods* 10:1213–1218.
{: .block-tip }

## Algorithmic Thinking: The Peak Calling Problem

Let me tell you about the first time I ran ChIP-seq analysis during my PhD.

I had beautiful peaks. Gorgeous enrichment. Except when I looked closer, I also had peaks in:
- Telomeres (my transcription factor doesn't bind there)
- Mitochondrial DNA (contamination)
- Highly repetitive regions (alignment artifacts)
- Random background noise that just happened to be slightly higher than average

The naive approach—"count reads in windows, call high regions as peaks"—gave me garbage. I needed an algorithm that understood the structure of the problem.

### How ChIP-seq Taught Me Algorithmic Thinking

**ChIP-seq gives you:** Millions of DNA fragments representing where your protein of interest was bound.

**Your challenge:** Where, *exactly*, were the binding sites?

This is algorithmic thinking: designing a step-by-step procedure that accounts for how your data was actually generated.

| ❌ **Naive Algorithm (What I Tried First)** | ✅ **Sophisticated Algorithm (MACS2)** |
|----------------------------------------------|----------------------------------------|
| 1. Align reads to genome | 1. Model local background using control samples |
| 2. Count reads in sliding windows | 2. Shift reads to estimate fragment centers |
| 3. Call regions with high counts as "peaks" | 3. Use dynamic lambda (local background varies!) |
| 4. Get overwhelmed by false positives | 4. Calculate fold enrichment AND statistical significance |
| 5. Spend weeks troubleshooting | 5. Call peaks using FDR cutoff |
|  | 6. Report peak summits, not just regions |

The difference? MACS2 doesn't just count. It **models the data generation process**: how reads are created from fragments, how background varies locally, how sequencing depth affects power. Then it uses that model to make better inferences.

This is the essence of algorithmic thinking: understanding *why* the data looks the way it does, then designing procedures that account for that structure.

> ##### Editorial Note: The Importance of Thoughtful Defaults
>
> Zhang et al. (2008) developed MACS specifically to address ChIP-seq's systematic biases. What makes it a landmark methods paper:

**Problem definition:** ChIP-seq enrichment isn't uniform. Background varies by:
- Local GC content
- Mappability
- Open chromatin state
- Sequencing depth artifacts

**Algorithmic innovation:** Dynamic local lambda calculation. Instead of one global background threshold, MACS estimates expected background in windows around each potential peak.

**Impact:** MACS became the field standard not just because it worked well, but because its defaults worked well. Most users never tuned parameters—the algorithm was designed around realistic assumptions about ChIP-seq data.

**For methods developers:** Good defaults are not laziness. They're a service to users who don't have the time or statistical background to optimize every parameter. Your algorithm should work out-of-the-box for 80% of use cases.

**Reference:** Zhang, Y. et al. (2008). "Model-based analysis of ChIP-Seq (MACS)." *Genome Biology* 9:R137.
{: .block-tip }

## The Computational Thinking You Already Had

Here's what I realized during my PhD, somewhere around year 4 when I was knee-deep in hMeRIP-seq analysis and trying to figure out why my peaks didn't make biological sense:

**I was already thinking computationally. I just didn't call it that.**

When I troubleshot why my Western blot didn't work, I was doing **decomposition**: breaking down the protocol into steps, testing each one systematically, identifying where the failure occurred.

When I noticed my ChIP peaks always appeared near transcription start sites and wondered if that was biological signal or technical artifact, I was doing **pattern recognition**: seeing structure in data and asking what it meant.

When I wrote detailed protocols for CRISPR cloning that could work for any guide RNA, I was doing **abstraction**: designing procedures that generalize beyond specific examples.

The transition to computational biology wasn't learning to think differently. It was learning to apply problem-solving skills I already had to questions where the "experiment" was running code instead of pipetting samples.

---

## What This Means for Reading Methods Papers

Next time you read a methods paper—especially if you're evaluating it for significance, rigor, or publication—ask yourself:

**Decomposition:**
- What is the experimental readout, and what biological question does it answer?
- What computational steps are required to go from raw data to biological conclusion?
- Are any of these steps new/challenging/rate-limiting for the field?

**Pattern recognition:**
- What patterns in the data indicate signal vs. noise?
- Are there features being exploited that weren't obvious at first (like ATAC fragment lengths)?
- What assumptions about data structure does the analysis make?

**Algorithmic thinking:**
- Could you explain the analysis procedure to someone and they'd get the same results?
- How does the algorithm handle edge cases (low coverage, ambiguous mappings, batch effects)?
- Are the defaults reasonable? Would naive users get good results out-of-the-box?

These questions aren't just academic. They're how you evaluate whether a method is truly innovative or just incrementally different from what already exists.

---

## Looking Ahead

Three methods. Three computational thinking lessons:

| Method | Year | Computational Skill Taught |
|--------|------|---------------------------|
| **Bisulfite sequencing** | 1992 | Decomposition—inference from transformed data |
| **ATAC-seq** | 2013 | Pattern recognition—signal in fragment lengths |
| **ChIP-seq peak calling** | 2008 | Algorithmic thinking—modeling data generation |

But here's what's interesting: we've only covered methods that work on *one data type* at a time. What happens when methods from different fields start talking to each other?

What happens when you want to measure chromatin accessibility AND gene expression AND DNA methylation in the *same cells*?

That's where we're going in Part 2: the multi-omics revolution, and the computational thinking skill that made it possible—**abstraction**.

---

## References

**Historical methods:**
- Frommer, M. et al. (1992). "A genomic sequencing protocol that yields a positive display of 5-methylcytosine residues in individual DNA strands." *PNAS* 89(5):1827-1831. [PubMed](https://pubmed.ncbi.nlm.nih.gov/1542678/)

- Buenrostro, J.D. et al. (2013). "Transposition of native chromatin for fast and sensitive epigenomic profiling of open chromatin, DNA-binding proteins and nucleosome position." *Nature Methods* 10:1213–1218. [PubMed](https://pubmed.ncbi.nlm.nih.gov/24097267/)

**Computational tools:**
- Zhang, Y. et al. (2008). "Model-based analysis of ChIP-Seq (MACS)." *Genome Biology* 9:R137. [PubMed](https://pubmed.ncbi.nlm.nih.gov/18798982/)

- Schep, A.N. et al. (2017). "chromVAR: inferring transcription-factor-associated accessibility from single-cell epigenomic data." *Nature Methods* 14:975–978. [PubMed](https://pubmed.ncbi.nlm.nih.gov/28825706/)

- Schep, A.N. et al. (2015). "Structured nucleosome fingerprints enable high-resolution mapping of chromatin architecture within regulatory regions." *Genome Research* 25:1757-1770. [PubMed](https://pubmed.ncbi.nlm.nih.gov/26314830/) (NucleoATAC)

---

**Next in this series:** *Part 2: When Chromatin Methods Converged—The Multi-Omics Revolution*

---

*This is Part 1 of a 3-part series on computational thinking for chromatin biologists. Written by a chromatin biologist who learned computational thinking the hard way—by running experiments that generated data I didn't know how to analyze.*