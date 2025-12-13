#!/usr/bin/env Rscript

# 07_pathway_analysis.R
# Performs functional enrichment analysis using clusterProfiler
# Usage: Rscript 07_pathway_analysis.R

# Load required libraries
suppressPackageStartupMessages({
  library(clusterProfiler)
  library(org.Mm.eg.db)
  library(AnnotationDbi)
  library(ggplot2)
  library(dplyr)
  library(enrichplot)
})

cat("Starting Functional Enrichment Analysis\n")
cat("================================================\n\n")

# Set directories
deg_dir <- "results/deg"
pathway_dir <- "results/pathways"
fig_dir <- "results/figures"

# Create output directory
dir.create(pathway_dir, showWarnings = FALSE, recursive = TRUE)

# ============================================================================
# Step 1: Load DEG Results
# ============================================================================
cat("Step 1: Loading differential expression results\n")

# Load significant DEGs
deg_results <- read.csv(
  file.path(deg_dir, "deseq2_results_significant.csv"),
  stringsAsFactors = FALSE)

cat(sprintf("  Loaded %d significant DEGs\n", nrow(deg_results)))

# Separate up and down regulated genes
up_genes <- deg_results %>% filter(regulation == "Up") %>% pull(gene_id)
down_genes <- deg_results %>% filter(regulation == "Down") %>% pull(gene_id)
all_sig_genes <- deg_results$gene_id

cat(sprintf("    Upregulated: %d genes\n", length(up_genes)))
cat(sprintf("    Downregulated: %d genes\n", length(down_genes)))

# ============================================================================
# Step 2: Gene ID Conversion
# ============================================================================
cat("\nStep 2: Converting gene IDs to Entrez IDs\n")

# Convert Ensembl IDs to Entrez IDs
# Remove version numbers from Ensembl IDs
all_sig_genes_clean <- gsub("\\..*", "", all_sig_genes)
up_genes_clean <- gsub("\\..*", "", up_genes)
down_genes_clean <- gsub("\\..*", "", down_genes)

# Convert to Entrez IDs
convert_to_entrez <- function(genes) {
  entrez <- mapIds(
    org.Mm.eg.db,
    keys = genes,
    column = "ENTREZID",
    keytype = "ENSEMBL",
    multiVals = "first")
  return(na.omit(entrez))
}

all_entrez <- convert_to_entrez(all_sig_genes_clean)
up_entrez <- convert_to_entrez(up_genes_clean)
down_entrez <- convert_to_entrez(down_genes_clean)

cat(sprintf("  Converted %d genes to Entrez IDs\n", length(all_entrez)))

# ============================================================================
# Step 3: Gene Ontology (GO) Enrichment
# ============================================================================
cat("\nStep 3: Performing GO enrichment analysis\n")

## 3a. GO - Biological Process
cat("  - GO: Biological Process\n")
go_bp <- enrichGO(
  gene = all_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE)

if (!is.null(go_bp) && nrow(go_bp) > 0) {
  write.csv(
    as.data.frame(go_bp),
    file = file.path(pathway_dir, "GO_biological_process.csv"),
    row.names = FALSE)
  cat(sprintf("    Found %d enriched BP terms\n", nrow(go_bp)))} else {
  cat("    No significant GO BP terms found\n")
}

## 3b. GO - Molecular Function
cat("  - GO: Molecular Function\n")
go_mf <- enrichGO(
  gene = all_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "MF",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE)

if (!is.null(go_mf) && nrow(go_mf) > 0) {
  write.csv(
    as.data.frame(go_mf),
    file = file.path(pathway_dir, "GO_molecular_function.csv"),
    row.names = FALSE)
  cat(sprintf("    Found %d enriched MF terms\n", nrow(go_mf)))
}

## 3c. GO - Cellular Component
cat("  - GO: Cellular Component\n")
go_cc <- enrichGO(
  gene = all_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "CC",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE)

if (!is.null(go_cc) && nrow(go_cc) > 0) {
  write.csv(
    as.data.frame(go_cc),
    file = file.path(pathway_dir, "GO_cellular_component.csv"),
    row.names = FALSE)
  cat(sprintf("    Found %d enriched CC terms\n", nrow(go_cc)))
}

# ============================================================================
# Step 4: KEGG Pathway Enrichment
# ============================================================================
cat("\nStep 4: Performing KEGG pathway analysis\n")

kegg <- enrichKEGG(
  gene = all_entrez,
  organism = "mmu",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05)

if (!is.null(kegg) && nrow(kegg) > 0) {
  # Convert gene IDs to symbols for readability
  kegg_readable <- setReadable(kegg, OrgDb = org.Mm.eg.db, keyType = "ENTREZID")
  
  write.csv(
    as.data.frame(kegg_readable),
    file = file.path(pathway_dir, "KEGG_pathways.csv"),
    row.names = FALSE)
  cat(sprintf("  Found %d enriched KEGG pathways\n", nrow(kegg)))
} else {
  cat("  No significant KEGG pathways found\n")
}

# ============================================================================
# Step 5: Separate Analysis for Up and Down Regulated Genes
# ============================================================================
cat("\nStep 5: Enrichment analysis for up and downregulated genes separately\n")

## Upregulated genes
cat("  - Upregulated genes (GO BP)\n")
go_bp_up <- enrichGO(
  gene = up_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE)

if (!is.null(go_bp_up) && nrow(go_bp_up) > 0) {
  write.csv(
    as.data.frame(go_bp_up),
    file = file.path(pathway_dir, "GO_BP_upregulated.csv"),
    row.names = FALSE)
  cat(sprintf("    Found %d enriched terms\n", nrow(go_bp_up)))
}

## Downregulated genes
cat("  - Downregulated genes (GO BP)\n")
go_bp_down <- enrichGO(
  gene = down_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE)

if (!is.null(go_bp_down) && nrow(go_bp_down) > 0) {
  write.csv(
    as.data.frame(go_bp_down),
    file = file.path(pathway_dir, "GO_BP_downregulated.csv"),
    row.names = FALSE)
  cat(sprintf("    Found %d enriched terms\n", nrow(go_bp_down)))
}

# ============================================================================
# Step 6: Gene Set Enrichment Analysis (GSEA)
# ============================================================================
cat("\nStep 6: Running GSEA\n")

# Prepare ranked gene list
deg_all <- read.csv(
  file.path(deg_dir, "deseq2_results_all.csv"),
  stringsAsFactors = FALSE)

# Create ranked list (by log2FC * -log10(pvalue))
deg_all$rank_metric <- sign(deg_all$log2FoldChange) * -log10(deg_all$pvalue)
deg_all <- deg_all[!is.na(deg_all$rank_metric) & !is.infinite(deg_all$rank_metric), ]

# Clean Ensembl IDs
deg_all$gene_id_clean <- gsub("\\..*", "", deg_all$gene_id)

# Convert to Entrez
deg_all$entrez <- mapIds(
  org.Mm.eg.db,
  keys = deg_all$gene_id_clean,
  column = "ENTREZID",
  keytype = "ENSEMBL",
  multiVals = "first")

# Remove NAs and create ranked list
deg_all <- deg_all[!is.na(deg_all$entrez), ]
gene_list <- deg_all$rank_metric
names(gene_list) <- deg_all$entrez
gene_list <- sort(gene_list, decreasing = TRUE)

cat(sprintf("  Created ranked list of %d genes\n", length(gene_list)))

# Run GSEA
gsea_go <- gseGO(
  geneList = gene_list,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pvalueCutoff = 0.05,
  pAdjustMethod = "BH",
  verbose = FALSE)

if (!is.null(gsea_go) && nrow(gsea_go) > 0) {
  gsea_go_readable <- setReadable(gsea_go, OrgDb = org.Mm.eg.db, keyType = "ENTREZID")
  write.csv(
    as.data.frame(gsea_go_readable),
    file = file.path(pathway_dir, "GSEA_GO_BP.csv"),
    row.names = FALSE)
  cat(sprintf("  Found %d enriched gene sets\n", nrow(gsea_go)))
}

# ============================================================================
# Step 7: Visualization
# ============================================================================
cat("\nStep 7: Generating enrichment plots\n")

## 7a. GO BP Dotplot
if (!is.null(go_bp) && nrow(go_bp) > 0) {
  cat("  - GO BP dotplot\n")
  p_go_dot <- dotplot(go_bp, showCategory = 20) +
    ggtitle("GO Biological Process Enrichment") +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave(
    file.path(fig_dir, "GO_BP_dotplot.png"),
    p_go_dot,
    width = 10,
    height = 8,
    dpi = 300)
}

## 7b. GO BP Barplot
if (!is.null(go_bp) && nrow(go_bp) > 0) {
  cat("  - GO BP barplot\n")
  p_go_bar <- barplot(go_bp, showCategory = 20) +
    ggtitle("GO Biological Process Enrichment") +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave(
    file.path(fig_dir, "GO_BP_barplot.png"),
    p_go_bar,
    width = 10,
    height = 8,
    dpi = 300)
}

## 7c. KEGG Dotplot
if (!is.null(kegg) && nrow(kegg) > 0) {
  cat("  - KEGG pathways dotplot\n")
  p_kegg_dot <- dotplot(kegg, showCategory = 20) +
    ggtitle("KEGG Pathway Enrichment") +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave(
    file.path(fig_dir, "KEGG_dotplot.png"),
    p_kegg_dot,
    width = 10,
    height = 8,
    dpi = 300)
}

## 7d. Enrichment Map (GO BP)
if (!is.null(go_bp) && nrow(go_bp) > 5) {
  cat("  - GO BP enrichment map\n")
  go_bp_pair <- pairwise_termsim(go_bp)
  p_emap <- emapplot(go_bp_pair, showCategory = 30) +
    ggtitle("GO BP Enrichment Map") +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave(
    file.path(fig_dir, "GO_BP_enrichment_map.png"),
    p_emap,
    width = 12,
    height = 10,
    dpi = 300)
}

## 7e. GSEA Plot
if (!is.null(gsea_go) && nrow(gsea_go) > 0) {
  cat("  - GSEA enrichment plots\n")
  
  # Plot top 5 enriched pathways
  for (i in 1:min(5, nrow(gsea_go))) {
    p_gsea <- gseaplot2(
      gsea_go,
      geneSetID = i,
      title = gsea_go$Description[i])
    
    ggsave(
      file.path(fig_dir, sprintf("GSEA_plot_%d.png", i)),
      p_gsea,
      width = 10,
      height = 6,
      dpi = 300)
  }
}

## 7f. Compare up vs down regulated genes
if (!is.null(go_bp_up) && !is.null(go_bp_down) && 
    nrow(go_bp_up) > 0 && nrow(go_bp_down) > 0) {
  cat("  - Comparison plot for up vs down regulated genes\n")
  
  # Create comparison object
  compare_list <- list(
    Upregulated = up_entrez,
    Downregulated = down_entrez)
  
  compare_go <- compareCluster(
    geneClusters = compare_list,
    fun = "enrichGO",
    OrgDb = org.Mm.eg.db,
    ont = "BP",
    pAdjustMethod = "BH",
    pvalueCutoff = 0.05,
    qvalueCutoff = 0.05)
  
  if (!is.null(compare_go) && nrow(compare_go) > 0) {
    p_compare <- dotplot(compare_go, showCategory = 10) +
      ggtitle("GO BP: Upregulated vs Downregulated Genes") +
      theme(plot.title = element_text(hjust = 0.5, face = "bold"))
    
    ggsave(
      file.path(fig_dir, "GO_BP_comparison.png"),
      p_compare,
      width = 12,
      height = 10,
      dpi = 300)
  }
}

# ============================================================================
# Final Summary
# ============================================================================
cat("\n================================================\n")
cat("Functional Enrichment Analysis Complete!\n")
cat("================================================\n\n")

cat("Enrichment results saved in:", pathway_dir, "\n")
cat("  - GO_biological_process.csv\n")
cat("  - GO_molecular_function.csv\n")
cat("  - GO_cellular_component.csv\n")
cat("  - KEGG_pathways.csv\n")
cat("  - GSEA_GO_BP.csv\n")
cat("  - GO_BP_upregulated.csv\n")
cat("  - GO_BP_downregulated.csv\n\n")

cat("Figures saved in:", fig_dir, "\n")
cat("  - GO_BP_dotplot.png\n")
cat("  - GO_BP_barplot.png\n")
cat("  - KEGG_dotplot.png\n")
cat("  - GO_BP_enrichment_map.png\n")
cat("  - GSEA_plot_*.png\n")
cat("  - GO_BP_comparison.png\n\n")

cat("Analysis pipeline complete!\n")

# Save session info
writeLines(
  capture.output(sessionInfo()),
  file.path(pathway_dir, "sessionInfo.txt")
)
