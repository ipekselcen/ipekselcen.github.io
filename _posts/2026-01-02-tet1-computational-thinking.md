---
layout: post
title: "What I Wish Someone Had Told Me About TET1: A Computational Thinking Journey"
date: 2026-01-02
description: Three years into my PhD, I finally understood what I was actually measuring. Here's what clicked.
tags: systems-biology computational-thinking epigenetics DNA-methylation
categories: SciComm
related_posts: true
toc:
  sidebar: left
---

I spent the first two years of my PhD memorizing pathways. "TET1 oxidizes 5-methylcytosine." Check. "5hmC is an intermediate in demethylation." Check. "TET enzymes regulate gene expression." Check.

Then I knocked out TET2 in my oligodendrocyte progenitor cells, ran RNA-seq, and... nothing made sense.

The patterns I saw didn't match any textbook. My PI was confused. I was confused. I'd generated beautiful data but had no framework to interpret it. That's when I realized: **I'd been memorizing recipes without understanding the logic**.

This post is what I wish someone had told me in year one. Not as a computational expert - I'm still learning - but as someone who finally started asking different questions.

## The Problem With How We Learn Biology

Here's how I was taught DNA methylation:

> **The Clean Story**
>
> - DNA gets methylated (5mC) → Gene silenced
> - DNA loses methylation → Gene active
> - TET enzymes reverse methylation
> - Therefore: TET knockout = more methylation = more silencing
{: .block-warning }

This made perfect sense in lectures. It completely failed in my experiments.

**Why?** Because biology isn't a linear pathway. It's a network with:
- **Redundancy** (TET1, TET2, AND TET3 - why three?)
- **Compensation** (lose one, others adapt)
- **Context-dependence** (same enzyme, different outcomes in different cells)
- **Multi-layer regulation** (not just DNA methylation - chromatin, RNA modifications, metabolic state)

Nobody told me this. I had to learn it by banging my head against confusing data for months.

## The Turning Point: TET1 Discovery

In 2009, TET1 was discovered.<sup>1</sup> The textbook version goes:

"TET1 oxidizes 5-methylcytosine, providing a mechanism for active DNA demethylation."

**What I missed** (and what took me years to appreciate): This wasn't just finding a new enzyme. It was revealing that **DNA methylation is a state space, not a binary switch**.

### What That Actually Means

Instead of:
```
Methylated (OFF) ⟷ Unmethylated (ON)
```

We have:
```
C → 5mC → 5hmC → 5fC → 5caC → C
```

**Why does this matter?** Because each state:
- Has different protein readers
- Exists at different stability levels
- Serves different regulatory functions
- Creates different biological outcomes

This means the cell can encode way more information than just "on" or "off." It can create states like:
- "Poised" (ready to activate quickly)
- "Active but dynamic" (fluctuating)
- "Progressively shutting down" (transitioning)
- "Stably repressed" (locked)

> **What Clicked For Me**
>
> When I first learned about 5hmC, I thought: "Oh, an intermediate. Cool."
>
> What I should have thought: "Wait - if 5hmC accumulates to 1% of all cytosines in ESCs, it's NOT just an intermediate. It's serving a function. The cell is CHOOSING to keep DNA in this intermediate state."
>
> That shift - from thinking about intermediates to thinking about **states the cell maintains** - changed everything.
{: .block-tip }

## My TET2 Confusion (And What It Taught Me)

Let me tell you about my actual data, because this is where linear thinking completely broke down.

**My prediction (linear thinking):**
- TET2 knockout → less 5hmC → more stable 5mC → genes stay repressed

**What I actually saw:**
- TET2 knockout → some 5hmC decrease BUT
- TET1 and TET3 expression increased (compensation)
- RNA modifications changed (unexpected)
- Chromatin accessibility shifted at unexpected sites
- Gene expression changes didn't correlate simply with 5hmC loss

**My PI's reaction:** "This is messy. Maybe technical variation?"

**What was actually happening:** The cell was adapting. Network compensation. Multi-layer regulation. **Exactly what you'd predict if you thought computationally**, but I didn't have that framework yet.

## What "Thinking Computationally" Actually Means

I used to think "computational biology" meant "learning Python and running pipelines."

That's not it.

**Computational thinking means asking:**
1. **What's the state space?** (Not just "on/off" - what are ALL possible states?)
2. **What are the network connections?** (Who compensates when something breaks?)
3. **What are the multi-layer regulations?** (DNA methylation doesn't act alone)
4. **What's the cell optimizing for?** (Stability vs. flexibility? Speed vs. accuracy?)

Let me show you what this looks like in practice.

### Question 1: Why Three TET Enzymes?

**Linear thinking:** "Evolution is messy. Probably redundant."

**Computational thinking:** "Redundancy in biology usually means something. Let me think about this as a network."

```python
# This is how I started thinking about it
# (Warning: I'm still learning Python, this is conceptual)

network = {
    'TET1': {'targets': gene_set, 'expression': 'constitutive'},
    'TET2': {'targets': gene_set, 'expression': 'inducible'},  
    'TET3': {'targets': gene_set, 'expression': 'tissue_specific'}
}

# Question: If I knock out TET2, what happens?
# Linear: TET2 targets lose 5hmC
# Network: Do TET1/3 compensate? Do cells reroute regulation?
```

When I finally looked at published TET1 knockout data,<sup>4</sup> mice were **viable and fertile**. Subtle defects, but mostly fine.

**Why?** Network compensation. TET2 and TET3 picked up the slack.

**What this taught me:** When you see three enzymes doing similar things, don't think "redundant waste." Think "robust system with failsafes."

The cell isn't stupid. We're just not asking the right questions.

### Question 2: Is 5hmC Transient or Stable?

This is where computational thinking saved me from misinterpreting my own data.

**What I measured:** 5hmC at certain promoters in my OPCs.

**Linear interpretation:** "5hmC is present, so demethylation is happening here."

**Computational question:** "Wait - if 5hmC is just a transient intermediate, why is it so abundant in ESCs (1% of all cytosines)?"<sup>3</sup>

Let me think about kinetics:
```r
# If 5hmC is transient:
# k1 (5mC → 5hmC) ≈ k2 (5hmC → 5fC)
# Steady state: [5hmC] should be very low

# If 5hmC is stable:
# k1 (5mC → 5hmC) >> k2 (5hmC → 5fC)  
# Steady state: [5hmC] accumulates

# The data shows: 5hmC is ABUNDANT
# Therefore: k2 must be slow
# Meaning: 5hmC is not just passing through
```

**What this means:** 5hmC isn't just "on the way to demethylation." It's a **mark the cell maintains** to keep genes in a poised state.

**Why this matters for my research:** When I see 5hmC at a promoter in my OPCs, it might not mean "actively demethylating." It might mean "maintaining plasticity" - ready to go either way depending on signals.

Completely different biological interpretation. Same data.

> **The Struggle Is Real**
>
> I didn't figure this out quickly. I spent MONTHS confused about my 5hmC data. I kept thinking "is my hMeRIP-seq bad?" when really, I was asking the wrong questions.
>
> The turning point was reading papers about 5hmC in development and realizing: **the cell uses 5hmC to maintain flexible states**. It's not a bug, it's a feature.
{: .block-warning }

## The Multi-Layer Reality Nobody Tells You

Here's what really frustrated me: **Every paper I read would focus on ONE layer of regulation** and claim causality.

"TET2 mutation causes reduced 5hmC, leading to gene X downregulation."

But when I looked at my data, I had to ask:
- Did chromatin accessibility change? (Yes)
- Did RNA modifications change? (Yes, unexpectedly)
- Did metabolic state shift? (Probably)
- Did other TET enzymes compensate? (Definitely)
- Were there feedback loops I'm missing? (Almost certainly)

**The reality:** DNA methylation is ONE layer in a multi-layer regulatory system.

```
Cell State
    ↓
Metabolic State → ATP levels → Chromatin Remodeling
    ↓                              ↓
Transcription Factors → Chromatin Accessibility
    ↓                              ↓
DNA Methylation (5mC/5hmC) ← RNA Modifications
    ↓                              ↓
Histone Modifications → Gene Expression
    ↓
Feedback Loops
```

**When you perturb ONE thing** (like knocking out TET2), the **entire system responds**. You're not seeing "the effect of TET2" - you're seeing the **system's adaptation to losing TET2**.

This is why:
- My RNA-seq alone didn't tell the story
- I needed ATAC-seq to see chromatin changes
- I needed hMeRIP-seq to see RNA modification responses
- I needed metabolic profiling to understand the cellular state
- I STILL don't have the complete picture

## What I Do Differently Now

I'm not going to pretend I have this figured out. I'm still learning. But here's what changed in how I approach my research:

### Before Running Experiments

**Old me:** "I'll knock out TET2 and do RNA-seq."

**Current me:** 
1. Draw the network on paper. Where are backup systems?
2. What multi-layer regulations exist?
3. What would linear thinking predict?
4. What would network compensation predict?
5. What additional data would I need to distinguish these?

**This doesn't mean I always do the perfect experiment.** Money and time are real constraints. But at least I **know what I'm missing**.

### When Analyzing Data

**Old me:** Run DESeq2 → Get gene list → Run GO enrichment → Call it a day

**Current me:**
```r
# After DESeq2, ask:
# 1. Does this pattern match network predictions?
# 2. Are compensatory genes changing?
# 3. What if I'm measuring adaptation, not direct effects?
# 4. What other layers should I check?

# Example from my actual analysis:
results <- DESeq2_results
up_genes <- filter(results, log2FC > 1, padj < 0.05)

# Check: Are TET1/TET3 in my up-regulated genes?
# If yes → network compensation, as predicted
# If no → something else is going on, investigate
```

### When Reading Papers

**Old me:** Trust the interpretation in the abstract.

**Current me:** 
- Did they check for compensation?
- Is this correlation or causation?
- What layers of regulation did they ignore?
- Would their conclusions hold if the system adapted?

**Example:** I recently read a paper claiming "TET2 loss causes specific gene downregulation."

Red flags:
- ❌ Didn't measure TET1/TET3 (compensation?)
- ❌ Didn't measure chromatin state (accessibility changes?)
- ❌ Endpoint analysis only (what about dynamics?)
- ❌ Assumed direct causality (network effects?)

I'm not saying the paper is wrong. I'm saying **their interpretation assumed linearity** in a clearly non-linear system.

## The Checklist I Use Now

Before making claims about my data, I ask:

**□ State Space Questions**
- [ ] Am I thinking binary when I should think spectrum?
- [ ] What states can the system occupy?
- [ ] What transitions are possible?

**□ Network Questions**
- [ ] What compensates if this breaks?
- [ ] Are there parallel pathways?
- [ ] What feedback loops exist?

**□ Multi-Layer Questions**
- [ ] What other regulatory layers are involved?
- [ ] Did I measure them?
- [ ] If not, how does that limit my interpretation?

**□ Plasticity Questions**
- [ ] Is the cell adapting to my perturbation?
- [ ] Am I measuring steady-state or transition?
- [ ] Would temporal dynamics change my interpretation?

**□ Causality Questions**
- [ ] Am I claiming correlation or causation?
- [ ] What experiment would actually test causality?
- [ ] What would change my conclusion?

> **Reality Check**
>
> Do I do all of this perfectly? No.
>
> Do I have time and money to measure every layer? No.
>
> But at least I **know what I'm not measuring** and can qualify my claims accordingly.
>
> That's the difference.
{: .block-tip }

## What I'm Still Learning

Let me be honest about where I struggle:

**1. When to stop adding complexity**

I can spiral into "but what about..." forever. Sometimes you need to make simplifying assumptions to make progress. I'm still learning where to draw that line.

**2. Quantitative predictions**

I can think about networks qualitatively. Making actual quantitative predictions? That's harder. I'm working on it.

**3. Integrating all the data**

I have RNA-seq, ATAC-seq, hMeRIP-seq sitting on my hard drive. Integrating them properly is... a work in progress. The conceptual framework is there. The practical execution is messy.

**4. Communicating uncertainty**

In talks, PIs want definitive statements. "TET2 regulates gene X." But what I actually mean is: "TET2 loss correlates with gene X changes, possibly through network adaptation involving chromatin and RNA modifications, but I haven't proven causality."

How do you say that in a conference talk without sounding wishy-washy?

Still figuring that out.

## Why This Matters For You

If you're early in your PhD (or considering grad school), **please learn this framework earlier than I did**.

Not because it makes research easier - it doesn't. If anything, it makes you realize how much you DON'T know.

But it will save you from:
- ❌ Making overclaimed conclusions
- ❌ Being confused when knockouts don't match predictions
- ❌ Missing compensation mechanisms
- ❌ Thinking your "messy" data is bad when it's actually informative

**Biology is not linear.** Cells are plastic, adaptive, multi-layer regulatory systems.

**The sooner you think that way, the better.**

## What's Next

I'm working on a companion post about chromatin accessibility using the same framework - thinking about it as a probability landscape rather than "open" vs "closed."

I'm also writing up my TET2 work (finally). The compensation mechanisms we found are... not what textbooks would predict. But they make perfect sense when you think computationally.

After publication, I'll write about what we learned and what I still don't understand.

For now, if you're struggling with confusing epigenetics data, know that:
1. You're not alone
2. Your data probably isn't bad
3. You might just be asking linear questions about a non-linear system

Start thinking about networks, plasticity, and multi-layer regulation. Your confusion might turn into clarity.

At least, that's what happened for me.

> **Coming Up**
>
> - "Chromatin Accessibility as Probability: What Your ATAC-seq Really Measures"
> - "The TET2 Story: When Compensation Mechanisms Surprise You" (after publication)
> - "How I Actually Analyze Multi-Omics Data (Messy Reality Edition)"
{: .block-tip }

---

### References & Further Reading

**The papers that changed how I think:**

1. Tahiliani M, et al. (2009) "Conversion of 5-methylcytosine to 5-hydroxymethylcytosine in mammalian DNA by MLL partner TET1." *Science* 324(5929):930-5. 
   - *Why it matters: Revealed the state space of DNA methylation*

2. Kriaucionis S, Heintz N. (2009) "The nuclear DNA base 5-hydroxymethylcytosine is present in Purkinje neurons and the brain." *Science* 324(5929):929-30.

3. Koh KP, et al. (2011) "Tet1 and Tet2 regulate 5-hydroxymethylcytosine production and cell lineage specification in mouse embryonic stem cells." *Cell Stem Cell* 8(2):200-13.
   - *Why it matters: Showed 5hmC is abundant, not transient*

4. Dawlaty MM, et al. (2011) "Tet1 is dispensable for maintaining pluripotency and its loss is compatible with embryonic and postnatal development." *Cell Stem Cell* 9(2):166-75.
   - *Why it matters: Network compensation in action*

5. Wu H, et al. (2011) "Genome-wide analysis of 5-hydroxymethylcytosine distribution reveals its dual function in transcriptional regulation in mouse embryonic stem cells." *Genes Dev* 25(7):679-84.

6. Huang Y, et al. (2014) "Distinct roles of the methylcytosine oxidases Tet1 and Tet2 in mouse embryonic stem cells." *PNAS* 111(4):1361-6.

**On network thinking:**

7. Alon U. (2007) "Network motifs: theory and experimental approaches." *Nat Rev Genet* 8:450–461.
   - *For when you want to formalize network thinking*

8. Barabási AL, Oltvai ZN. (2004) "Network biology: understanding the cell's functional organization." *Nat Rev Genet* 5:101–113.

**What I'm reading now:**

- Anything by Uri Alon on systems biology
- Papers on cellular plasticity and adaptive responses
- Multi-omics integration methods (still learning!)

---

*This is part of my "Systems Biology for Biologists" series, where I'm documenting what I'm learning as I learn it. Mistakes, confusions, and all.*

*If you're also struggling with these concepts, let's struggle together. Science is hard.*