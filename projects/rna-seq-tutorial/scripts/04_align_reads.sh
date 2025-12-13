#!/bin/bash

# 04_align_reads.sh
# Aligns trimmed reads to reference genome using STAR
# Usage: bash 04_align_reads.sh

set -e
set -u

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Starting Read Alignment with STAR${NC}"

# Directories
TRIMMED_DIR="data/trimmed"
ALIGN_DIR="results/aligned"
REF_DIR="data/reference"
GENOME_DIR="${REF_DIR}/star_index"
THREADS=16

# Create output directories
mkdir -p ${ALIGN_DIR}
mkdir -p ${GENOME_DIR}

# Reference files
GENOME_FASTA="${REF_DIR}/Mus_musculus.GRCm39.dna.primary_assembly.fa"
GTF="${REF_DIR}/Mus_musculus.GRCm39.115.gtf"

echo -e "${YELLOW}Step 1: Building STAR genome index${NC}"

# Check if index already exists
if [ ! -f "${GENOME_DIR}/SAindex" ]; then
  echo "Building STAR index (this may take 30-60 minutes)..."
  
  STAR \
    --runMode genomeGenerate \
    --genomeDir ${GENOME_DIR} \
    --genomeFastaFiles ${GENOME_FASTA} \
    --sjdbGTFfile ${GTF} \
    --sjdbOverhang 99 \
    --runThreadN ${THREADS}
    
  echo -e "${GREEN}STAR index built successfully${NC}"
else
  echo -e "${YELLOW}STAR index already exists, skipping...${NC}"
fi

echo -e "${YELLOW}Step 2: Aligning reads to genome${NC}"

# Read metadata and align each sample
while IFS=',' read -r sample_id sra_id condition replicate fastq_1 fastq_2; do
  # Skip header
  if [ "$sample_id" == "sample_id" ]; then
    continue
  fi
  
  echo -e "${GREEN}Aligning ${sample_id}...${NC}"
  
  # Check if already aligned
  if [ -f "${ALIGN_DIR}/${sample_id}_Aligned.sortedByCoord.out.bam" ]; then
    echo -e "${YELLOW}${sample_id} already aligned, skipping...${NC}"
    continue
  fi
  
  # Define trimmed file names
  READ1="${TRIMMED_DIR}/${sra_id}_1_val_1.fq.gz"
  READ2="${TRIMMED_DIR}/${sra_id}_2_val_2.fq.gz"
  
  # Run STAR alignment
  STAR \
    --runMode alignReads \
    --genomeDir ${GENOME_DIR} \
    --readFilesIn ${READ1} ${READ2} \
    --readFilesCommand zcat \
    --outFileNamePrefix ${ALIGN_DIR}/${sample_id}_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard \
    --quantMode GeneCounts \
    --runThreadN ${THREADS}
    
  echo -e "${GREEN}${sample_id} aligned successfully${NC}"
  
done < data/metadata.csv

echo -e "${YELLOW}Step 3: Indexing BAM files${NC}"

# Index all BAM files
for BAM in ${ALIGN_DIR}/*_Aligned.sortedByCoord.out.bam; do
  echo "Indexing $(basename ${BAM})..."
  samtools index -@ ${THREADS} ${BAM}
done

echo -e "${YELLOW}Step 4: Generating alignment statistics${NC}"

# Create summary statistics file
echo "sample_id,total_reads,uniquely_mapped,mapped_multiple,unmapped" > ${ALIGN_DIR}/alignment_stats.csv

for LOG in ${ALIGN_DIR}/*_Log.final.out; do
  SAMPLE=$(basename ${LOG} _Log.final.out)
  
  TOTAL=$(grep "Number of input reads" ${LOG} | awk '{print $NF}')
  UNIQUE=$(grep "Uniquely mapped reads number" ${LOG} | awk '{print $NF}')
  MULTI=$(grep "Number of reads mapped to multiple loci" ${LOG} | awk '{print $NF}')
  UNMAPPED=$(grep "Number of reads unmapped: too short" ${LOG} | awk '{print $NF}')
  
  echo "${SAMPLE},${TOTAL},${UNIQUE},${MULTI},${UNMAPPED}" >> ${ALIGN_DIR}/alignment_stats.csv
done

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Alignment Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Aligned BAM files: ${ALIGN_DIR}/*_Aligned.sortedByCoord.out.bam"
echo "Alignment statistics: ${ALIGN_DIR}/alignment_stats.csv"
echo ""
echo -e "${YELLOW}Alignment Summary:${NC}"
cat ${ALIGN_DIR}/alignment_stats.csv | column -t -s,
echo ""
echo -e "${YELLOW}Key metrics:${NC}"
echo "  - Uniquely mapped reads should be >80%"
echo "  - Unmapped reads should be <10%"
echo ""
echo -e "${YELLOW}Next step: Count reads per gene${NC}"
echo "bash scripts/05_count_reads.sh"
