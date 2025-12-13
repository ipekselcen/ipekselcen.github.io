#!/usr/bin/env Rscript
# 06_differential_expression.R
# Performs differential expression analysis using DESeq2
# Usage: Rscript 06_differential_expression.R

# Load required libraries
suppressPackageStartupMessages({
  library(DESeq2)
  library(ggplot2)
  library(ComplexHeatmap)
  library(circlize)
  library(dplyr)
  library(tidyr)
  library(ggrepel)
})

cat("Starting Differential Expression Analysis\n\n")

# Set directories
count_dir <- "results/counts"
deg_dir <- "results/deg"
fig_dir <- "results/figures"

dir.create(deg_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# Load data
cat("Loading data...\n")

counts <- read.table(
  file.path(count_dir, "count_matrix_clean.txt"),
  header = TRUE,
  row.names = 1,
  check.names = FALSE
)

metadata <- read.csv("data/metadata.csv", stringsAsFactors = FALSE)
rownames(metadata) <- metadata$sample_id
metadata <- metadata[colnames(counts), ]

cat(sprintf("  %d genes, %d samples\n\n", nrow(counts), ncol(counts)))

# Run DESeq2
cat("Running DESeq2...\n")

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ condition
)

# Filter low counts
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep, ]

# Set reference
dds$condition <- relevel(dds$condition, ref = "Control")

# Run analysis
dds <- DESeq(dds)
res <- results(dds, contrast = c("condition", "Dnmt1_KO", "Control"))
res <- res[order(res$padj), ]

cat("\nDEG Summary (FDR < 0.05):\n")
print(summary(res, alpha = 0.05))

# Save results
cat("\nSaving results...\n")

normalized_counts <- counts(dds, normalized = TRUE)
write.csv(normalized_counts, file.path(deg_dir, "normalized_counts.csv"))

res_df <- as.data.frame(res)
res_df$gene_id <- rownames(res_df)
res_df$regulation <- "Not Significant"
res_df$regulation[res_df$log2FoldChange > 1 & res_df$padj < 0.05] <- "Up"
res_df$regulation[res_df$log2FoldChange < -1 & res_df$padj < 0.05] <- "Down"

write.csv(res_df, file.path(deg_dir, "deseq2_results_all.csv"), row.names = FALSE)

sig_genes <- res_df[res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1, ]
write.csv(sig_genes, file.path(deg_dir, "deseq2_results_significant.csv"), row.names = FALSE)

cat(sprintf("  DEGs: %d (Up: %d, Down: %d)\n\n", 
            nrow(sig_genes), 
            sum(sig_genes$regulation == "Up"),
            sum(sig_genes$regulation == "Down")))

# Generate plots
cat("Generating plots...\n")

## PCA
cat("  - PCA\n")
vsd <- vst(dds, blind = FALSE)
pca_data <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pca_data, "percentVar"))

p_pca <- ggplot(pca_data, aes(x = PC1, y = PC2, color = condition)) +
  geom_point(size = 5) +
  geom_text_repel(aes(label = name), size = 3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  theme_bw() +
  ggtitle("PCA - Sample Clustering")

ggsave(file.path(fig_dir, "pca_plot.png"), p_pca, width = 8, height = 6, dpi = 300)

## Sample Correlation
cat("  - Sample correlation\n")
sample_cor <- cor(normalized_counts)

png(file.path(fig_dir, "sample_correlation.png"), width = 2400, height = 2400, res = 300)

Heatmap(
  sample_cor,
  name = "Correlation",
  col = colorRamp2(c(0.8, 0.9, 1), c("blue", "white", "red")),
  cell_fun = function(j, i, x, y, width, height, fill) {
    grid.text(sprintf("%.2f", sample_cor[i, j]), x, y, gp = gpar(fontsize = 10))
  },
  column_title = "Sample Correlation"
)

dev.off()

## Volcano Plot
cat("  - Volcano plot\n")
volcano_data <- res_df
volcano_data$log10padj <- -log10(volcano_data$padj)

top_genes <- volcano_data %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 2) %>%
  arrange(padj) %>%
  head(20)

p_volcano <- ggplot(volcano_data, aes(x = log2FoldChange, y = log10padj)) +
  geom_point(aes(color = regulation), alpha = 0.6, size = 1.5) +
  scale_color_manual(values = c("Up" = "red", "Down" = "blue", "Not Significant" = "gray")) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
  geom_text_repel(data = top_genes, aes(label = gene_id), size = 3, max.overlaps = 20) +
  theme_bw() +
  labs(x = "Log2 Fold Change", y = "-Log10 Adj P-value", 
       title = "Volcano Plot - Dnmt1 KO vs Control")

ggsave(file.path(fig_dir, "volcano_plot.png"), p_volcano, width = 10, height = 8, dpi = 300)

## Heatmap of Top 50 DEGs
cat("  - Heatmap (top 50 DEGs)\n")

top_degs <- head(sig_genes, 50)$gene_id
heatmap_data_scaled <- t(scale(t(normalized_counts[top_degs, ])))

col_annotation <- HeatmapAnnotation(
  Condition = metadata$condition,
  col = list(Condition = c("Control" = "#4575b4", "Dnmt1_KO" = "#d73027"))
)

png(file.path(fig_dir, "heatmap_top_degs.png"), width = 2400, height = 3000, res = 300)

Heatmap(
  heatmap_data_scaled,
  name = "Z-score",
  col = colorRamp2(c(-2, 0, 2), c("blue", "white", "red")),
  top_annotation = col_annotation,
  column_title = "Top 50 DEGs",
  row_names_gp = gpar(fontsize = 6),
  cluster_columns = TRUE,
  cluster_rows = TRUE
)

dev.off()

# Summary
cat("\n========================================\n")
cat("Analysis Complete!\n")
cat("========================================\n\n")
cat("Results: results/deg/\n")
cat("Figures: results/figures/\n\n")
cat("Next: Rscript scripts/07_pathway_analysis.R\n")

writeLines(capture.output(sessionInfo()), file.path(deg_dir, "sessionInfo.txt"))
