#!/usr/bin/env Rscript

# 06_differential_expression.R
# Performs differential expression analysis using DESeq2
# Usage: Rscript 06_differential_expression.R

# Load required libraries
suppressPackageStartupMessages({
  library(DESeq2)
  library(ggplot2)
  library(pheatmap)
  library(RColorBrewer)
  library(dplyr)
  library(tidyr)
  library(ggrepel)
})

cat("Starting Differential Expression Analysis with DESeq2\n")
cat("================================================\n\n")

# Set directories
count_dir <- "results/counts"
deg_dir <- "results/deg"
fig_dir <- "results/figures"

# Create output directories
dir.create(deg_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# ============================================================================
# Step 1: Load Data
# ============================================================================
cat("Step 1: Loading count data and metadata\n")

# Load count matrix
counts <- read.table(
  file.path(count_dir, "count_matrix_clean.txt"),
  header = TRUE,
  row.names = 1,
  check.names = FALSE
)

# Load metadata
metadata <- read.csv("data/metadata.csv", stringsAsFactors = FALSE)
rownames(metadata) <- metadata$sample_id

# Ensure count matrix columns match metadata rows
metadata <- metadata[colnames(counts), ]

cat(sprintf("  Loaded %d genes across %d samples\n", nrow(counts), ncol(counts)))
cat(sprintf("  Conditions: %s\n", paste(unique(metadata$condition), collapse = ", ")))

# ============================================================================
# Step 2: Create DESeq2 Object
# ============================================================================
cat("\nStep 2: Creating DESeq2 dataset\n")

# Create DESeq2 dataset
dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ condition
)

# Pre-filtering: keep genes with at least 10 reads total
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep, ]

cat(sprintf("  Filtered to %d genes with >= 10 total reads\n", sum(keep)))

# Set reference level (control group)
dds$condition <- relevel(dds$condition, ref = "Control")

# ============================================================================
# Step 3: Run DESeq2
# ============================================================================
cat("\nStep 3: Running DESeq2 analysis\n")

# Run DESeq2
dds <- DESeq(dds)

# Get results
res <- results(dds, contrast = c("condition", "Treatment", "Control"))

# Order by adjusted p-value
res <- res[order(res$padj), ]

# Summary
cat("\nDifferential Expression Summary (FDR < 0.05):\n")
print(summary(res, alpha = 0.05))

# ============================================================================
# Step 4: Extract Normalized Counts
# ============================================================================
cat("\nStep 4: Extracting normalized counts\n")

# Get normalized counts
normalized_counts <- counts(dds, normalized = TRUE)

# Save normalized counts
write.csv(
  normalized_counts,
  file = file.path(deg_dir, "normalized_counts.csv"),
  quote = FALSE
)

# ============================================================================
# Step 5: Save Results
# ============================================================================
cat("\nStep 5: Saving results\n")

# Convert results to data frame
res_df <- as.data.frame(res)
res_df$gene_id <- rownames(res_df)

# Classify genes as up/down/not significant
res_df$regulation <- "Not Significant"
res_df$regulation[res_df$log2FoldChange > 1 & res_df$padj < 0.05] <- "Up"
res_df$regulation[res_df$log2FoldChange < -1 & res_df$padj < 0.05] <- "Down"

# Save all results
write.csv(
  res_df,
  file = file.path(deg_dir, "deseq2_results_all.csv"),
  row.names = FALSE,
  quote = FALSE
)

# Save significant DEGs only
sig_genes <- res_df[res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1, ]
write.csv(
  sig_genes,
  file = file.path(deg_dir, "deseq2_results_significant.csv"),
  row.names = FALSE,
  quote = FALSE
)

cat(sprintf("  Total DEGs (|log2FC| > 1, FDR < 0.05): %d\n", nrow(sig_genes)))
cat(sprintf("    Upregulated: %d\n", sum(sig_genes$regulation == "Up")))
cat(sprintf("    Downregulated: %d\n", sum(sig_genes$regulation == "Down")))

# ============================================================================
# Step 6: Quality Control Plots
# ============================================================================
cat("\nStep 6: Generating quality control plots\n")

## 6a. PCA Plot
cat("  - PCA plot\n")
vsd <- vst(dds, blind = FALSE)

pca_data <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pca_data, "percentVar"))

p_pca <- ggplot(pca_data, aes(x = PC1, y = PC2, color = condition)) +
  geom_point(size = 5) +
  geom_text_repel(aes(label = name), size = 3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  theme_bw() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  ggtitle("PCA Plot - Sample Clustering")

ggsave(
  file.path(fig_dir, "pca_plot.png"),
  p_pca,
  width = 8,
  height = 6,
  dpi = 300
)

## 6b. Sample Correlation Heatmap
cat("  - Sample correlation heatmap\n")
sample_cor <- cor(normalized_counts)

png(
  file.path(fig_dir, "sample_correlation.png"),
  width = 2400,
  height = 2400,
  res = 300
)
pheatmap(
  sample_cor,
  color = colorRampPalette(rev(brewer.pal(9, "RdBu")))(100),
  main = "Sample Correlation Heatmap",
  display_numbers = TRUE,
  number_format = "%.2f"
)
dev.off()

## 6c. Dispersion Plot
cat("  - Dispersion plot\n")
png(
  file.path(fig_dir, "dispersion_plot.png"),
  width = 2400,
  height = 1800,
  res = 300
)
plotDispEsts(dds, main = "Dispersion Estimates")
dev.off()

# ============================================================================
# Step 7: Differential Expression Plots
# ============================================================================
cat("\nStep 7: Generating differential expression plots\n")

## 7a. MA Plot
cat("  - MA plot\n")
png(
  file.path(fig_dir, "ma_plot.png"),
  width = 2400,
  height = 1800,
  res = 300
)
plotMA(res, alpha = 0.05, main = "MA Plot", ylim = c(-5, 5))
dev.off()

## 7b. Volcano Plot
cat("  - Volcano plot\n")

# Prepare data for volcano plot
volcano_data <- res_df
volcano_data$log10padj <- -log10(volcano_data$padj)

# Label top genes
top_genes <- volcano_data %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 2) %>%
  arrange(padj) %>%
  head(20)

p_volcano <- ggplot(volcano_data, aes(x = log2FoldChange, y = log10padj)) +
  geom_point(aes(color = regulation), alpha = 0.6, size = 1.5) +
  scale_color_manual(values = c(
    "Up" = "red",
    "Down" = "blue",
    "Not Significant" = "gray"
  )) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black") +
  geom_text_repel(
    data = top_genes,
    aes(label = gene_id),
    size = 3,
    max.overlaps = 20
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  labs(
    x = "Log2 Fold Change",
    y = "-Log10 Adjusted P-value",
    title = "Volcano Plot - Treatment vs Control",
    color = "Regulation"
  )

ggsave(
  file.path(fig_dir, "volcano_plot.png"),
  p_volcano,
  width = 10,
  height = 8,
  dpi = 300
)

## 7c. Heatmap of Top DEGs
cat("  - Heatmap of top differentially expressed genes\n")

# Select top 50 DEGs by adjusted p-value
top_degs <- head(sig_genes, 50)$gene_id

# Get normalized counts for these genes
heatmap_data <- normalized_counts[top_degs, ]

# Z-score transformation
heatmap_data_scaled <- t(scale(t(heatmap_data)))

# Annotation for samples
annotation_col <- data.frame(
  Condition = metadata$condition,
  row.names = rownames(metadata)
)

png(
  file.path(fig_dir, "heatmap_top_degs.png"),
  width = 2400,
  height = 3000,
  res = 300
)
pheatmap(
  heatmap_data_scaled,
  annotation_col = annotation_col,
  color = colorRampPalette(rev(brewer.pal(11, "RdBu")))(100),
  scale = "none",
  main = "Top 50 Differentially Expressed Genes",
  show_rownames = TRUE,
  fontsize_row = 6,
  cluster_cols = TRUE,
  cluster_rows = TRUE
)
dev.off()

# ============================================================================
# Step 8: Expression Profiles
# ============================================================================
cat("\nStep 8: Generating expression profile plots\n")

# Plot top upregulated genes
top_up <- sig_genes %>%
  filter(regulation == "Up") %>%
  arrange(desc(log2FoldChange)) %>%
  head(6)

# Prepare data for plotting
plot_data <- normalized_counts[top_up$gene_id, ] %>%
  as.data.frame() %>%
  rownames_to_column("gene_id") %>%
  pivot_longer(-gene_id, names_to = "sample_id", values_to = "counts") %>%
  left_join(metadata[, c("sample_id", "condition")], by = "sample_id")

p_top_up <- ggplot(plot_data, aes(x = condition, y = counts, color = condition)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.2, size = 2, alpha = 0.7) +
  facet_wrap(~gene_id, scales = "free_y", ncol = 3) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.background = element_rect(fill = "lightblue"),
    plot.title = element_text(hjust = 0.5, face = "bold")
  ) +
  labs(
    x = "Condition",
    y = "Normalized Counts",
    title = "Top 6 Upregulated Genes",
    color = "Condition"
  )

ggsave(
  file.path(fig_dir, "top_upregulated_genes.png"),
  p_top_up,
  width = 12,
  height = 8,
  dpi = 300
)

# ============================================================================
# Final Summary
# ============================================================================
cat("\n================================================\n")
cat("Differential Expression Analysis Complete!\n")
cat("================================================\n\n")

cat("Results saved in:", deg_dir, "\n")
cat("  - deseq2_results_all.csv\n")
cat("  - deseq2_results_significant.csv\n")
cat("  - normalized_counts.csv\n\n")

cat("Figures saved in:", fig_dir, "\n")
cat("  - pca_plot.png\n")
cat("  - sample_correlation.png\n")
cat("  - dispersion_plot.png\n")
cat("  - ma_plot.png\n")
cat("  - volcano_plot.png\n")
cat("  - heatmap_top_degs.png\n")
cat("  - top_upregulated_genes.png\n\n")

cat("Next step: Functional enrichment analysis\n")
cat("Rscript scripts/07_pathway_analysis.R\n")

# Save session info
writeLines(
  capture.output(sessionInfo()),
  file.path(deg_dir, "sessionInfo.txt")
)
