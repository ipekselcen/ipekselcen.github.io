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

cat("Starting Functional Enrichment Analysis\n\n")

# Set directories
deg_dir <- "results/deg"
pathway_dir <- "results/pathways"
fig_dir <- "results/figures"

dir.create(pathway_dir, showWarnings = FALSE, recursive = TRUE)

# Load DEGs
cat("Loading DEG results...\n")

deg_results <- read.csv(
  file.path(deg_dir, "deseq2_results_significant.csv"),
  stringsAsFactors = FALSE
)

up_genes <- deg_results %>% filter(regulation == "Up") %>% pull(gene_id)
down_genes <- deg_results %>% filter(regulation == "Down") %>% pull(gene_id)
all_sig_genes <- deg_results$gene_id

cat(sprintf("  DEGs: %d (Up: %d, Down: %d)\n\n", 
            length(all_sig_genes), length(up_genes), length(down_genes)))

# Convert gene IDs
cat("Converting to Entrez IDs...\n")

convert_to_entrez <- function(genes) {
  genes_clean <- gsub("\\..*", "", genes)
  entrez <- mapIds(
    org.Mm.eg.db,
    keys = genes_clean,
    column = "ENTREZID",
    keytype = "ENSEMBL",
    multiVals = "first"
  )
  return(na.omit(entrez))
}

all_entrez <- convert_to_entrez(all_sig_genes)
up_entrez <- convert_to_entrez(up_genes)
down_entrez <- convert_to_entrez(down_genes)

cat(sprintf("  Converted: %d genes\n\n", length(all_entrez)))

# GO Enrichment
cat("Running GO enrichment...\n")

go_bp <- enrichGO(
  gene = all_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE
)

if (!is.null(go_bp) && nrow(go_bp) > 0) {
  write.csv(
    as.data.frame(go_bp),
    file.path(pathway_dir, "GO_biological_process.csv"),
    row.names = FALSE
  )
  cat(sprintf("  GO BP: %d terms\n", nrow(go_bp)))
} else {
  cat("  GO BP: No significant terms\n")
}

go_mf <- enrichGO(
  gene = all_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "MF",
  pvalueCutoff = 0.05,
  readable = TRUE
)

if (!is.null(go_mf) && nrow(go_mf) > 0) {
  write.csv(
    as.data.frame(go_mf),
    file.path(pathway_dir, "GO_molecular_function.csv"),
    row.names = FALSE
  )
  cat(sprintf("  GO MF: %d terms\n", nrow(go_mf)))
}

go_cc <- enrichGO(
  gene = all_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "CC",
  pvalueCutoff = 0.05,
  readable = TRUE
)

if (!is.null(go_cc) && nrow(go_cc) > 0) {
  write.csv(
    as.data.frame(go_cc),
    file.path(pathway_dir, "GO_cellular_component.csv"),
    row.names = FALSE
  )
  cat(sprintf("  GO CC: %d terms\n\n", nrow(go_cc)))
}

# KEGG Pathways
cat("Running KEGG enrichment...\n")

kegg <- enrichKEGG(
  gene = all_entrez,
  organism = "mmu",
  pvalueCutoff = 0.05
)

if (!is.null(kegg) && nrow(kegg) > 0) {
  kegg_readable <- setReadable(kegg, OrgDb = org.Mm.eg.db, keyType = "ENTREZID")
  write.csv(
    as.data.frame(kegg_readable),
    file.path(pathway_dir, "KEGG_pathways.csv"),
    row.names = FALSE
  )
  cat(sprintf("  KEGG: %d pathways\n\n", nrow(kegg)))
} else {
  cat("  KEGG: No significant pathways\n\n")
}

# Separate enrichment for up/down genes
cat("Running separate enrichment (up vs down)...\n")

go_bp_up <- enrichGO(
  gene = up_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pvalueCutoff = 0.05,
  readable = TRUE
)

if (!is.null(go_bp_up) && nrow(go_bp_up) > 0) {
  write.csv(
    as.data.frame(go_bp_up),
    file.path(pathway_dir, "GO_BP_upregulated.csv"),
    row.names = FALSE
  )
  cat(sprintf("  Up: %d terms\n", nrow(go_bp_up)))
}

go_bp_down <- enrichGO(
  gene = down_entrez,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pvalueCutoff = 0.05,
  readable = TRUE
)

if (!is.null(go_bp_down) && nrow(go_bp_down) > 0) {
  write.csv(
    as.data.frame(go_bp_down),
    file.path(pathway_dir, "GO_BP_downregulated.csv"),
    row.names = FALSE
  )
  cat(sprintf("  Down: %d terms\n\n", nrow(go_bp_down)))
}

# GSEA
cat("Running GSEA...\n")

deg_all <- read.csv(
  file.path(deg_dir, "deseq2_results_all.csv"),
  stringsAsFactors = FALSE
)

deg_all$rank_metric <- sign(deg_all$log2FoldChange) * -log10(deg_all$pvalue)
deg_all <- deg_all[!is.na(deg_all$rank_metric) & !is.infinite(deg_all$rank_metric), ]
deg_all$gene_id_clean <- gsub("\\..*", "", deg_all$gene_id)

deg_all$entrez <- mapIds(
  org.Mm.eg.db,
  keys = deg_all$gene_id_clean,
  column = "ENTREZID",
  keytype = "ENSEMBL",
  multiVals = "first"
)

deg_all <- deg_all[!is.na(deg_all$entrez), ]
gene_list <- deg_all$rank_metric
names(gene_list) <- deg_all$entrez
gene_list <- sort(gene_list, decreasing = TRUE)

gsea_go <- gseGO(
  geneList = gene_list,
  OrgDb = org.Mm.eg.db,
  ont = "BP",
  pvalueCutoff = 0.05,
  verbose = FALSE
)

if (!is.null(gsea_go) && nrow(gsea_go) > 0) {
  gsea_go_readable <- setReadable(gsea_go, OrgDb = org.Mm.eg.db, keyType = "ENTREZID")
  write.csv(
    as.data.frame(gsea_go_readable),
    file.path(pathway_dir, "GSEA_GO_BP.csv"),
    row.names = FALSE
  )
  cat(sprintf("  GSEA: %d gene sets\n\n", nrow(gsea_go)))
}

# Generate plots
cat("Generating plots...\n")

if (!is.null(go_bp) && nrow(go_bp) > 0) {
  cat("  - GO BP dotplot\n")
  p_go_dot <- dotplot(go_bp, showCategory = 20) +
    ggtitle("GO Biological Process Enrichment")
  ggsave(file.path(fig_dir, "GO_BP_dotplot.png"), p_go_dot, width = 10, height = 8, dpi = 300)
  
  cat("  - GO BP barplot\n")
  p_go_bar <- barplot(go_bp, showCategory = 20) +
    ggtitle("GO Biological Process Enrichment")
  ggsave(file.path(fig_dir, "GO_BP_barplot.png"), p_go_bar, width = 10, height = 8, dpi = 300)
}

if (!is.null(kegg) && nrow(kegg) > 0) {
  cat("  - KEGG dotplot\n")
  p_kegg <- dotplot(kegg, showCategory = 20) +
    ggtitle("KEGG Pathway Enrichment")
  ggsave(file.path(fig_dir, "KEGG_dotplot.png"), p_kegg, width = 10, height = 8, dpi = 300)
}

if (!is.null(go_bp) && nrow(go_bp) > 5) {
  cat("  - GO enrichment map\n")
  go_bp_pair <- pairwise_termsim(go_bp)
  p_emap <- emapplot(go_bp_pair, showCategory = 30) +
    ggtitle("GO BP Enrichment Map")
  ggsave(file.path(fig_dir, "GO_BP_enrichment_map.png"), p_emap, width = 12, height = 10, dpi = 300)
}

if (!is.null(gsea_go) && nrow(gsea_go) > 0) {
  cat("  - GSEA plots (top 5)\n")
  for (i in 1:min(5, nrow(gsea_go))) {
    p_gsea <- gseaplot2(gsea_go, geneSetID = i, title = gsea_go$Description[i])
    ggsave(file.path(fig_dir, sprintf("GSEA_plot_%d.png", i)), p_gsea, width = 10, height = 6, dpi = 300)
  }
}

if (!is.null(go_bp_up) && !is.null(go_bp_down) && 
    nrow(go_bp_up) > 0 && nrow(go_bp_down) > 0) {
  cat("  - Up vs Down comparison\n")
  
  compare_list <- list(Upregulated = up_entrez, Downregulated = down_entrez)
  compare_go <- compareCluster(
    geneClusters = compare_list,
    fun = "enrichGO",
    OrgDb = org.Mm.eg.db,
    ont = "BP",
    pvalueCutoff = 0.05
  )
  
  if (!is.null(compare_go) && nrow(compare_go) > 0) {
    p_compare <- dotplot(compare_go, showCategory = 10) +
      ggtitle("GO BP: Up vs Down Regulated")
    ggsave(file.path(fig_dir, "GO_BP_comparison.png"), p_compare, width = 12, height = 10, dpi = 300)
  }
}

# Summary
cat("\n========================================\n")
cat("Enrichment Analysis Complete!\n")
cat("========================================\n\n")
cat("Results: results/pathways/\n")
cat("Figures: results/figures/\n\n")
cat("Pipeline complete!\n")

writeLines(capture.output(sessionInfo()), file.path(pathway_dir, "sessionInfo.txt"))
