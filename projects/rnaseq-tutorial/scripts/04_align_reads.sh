#!/bin/bash
# 04_align_reads.sh
# Aligns trimmed reads to reference genome using STAR
# Usage: bash 04_align_reads.sh

set -e
set -u

echo "Starting Read Alignment with STAR"
echo ""

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

# Build STAR genome index (if needed)
if [ ! -f "${GENOME_DIR}/SAindex" ]; then
  echo "Building STAR genome index (30-60 minutes)..."
  
  STAR \
    --runMode genomeGenerate \
    --genomeDir ${GENOME_DIR} \
    --genomeFastaFiles ${GENOME_FASTA} \
    --sjdbGTFfile ${GTF} \
    --sjdbOverhang 99 \
    --runThreadN ${THREADS}
    
  echo "  Index complete"
else
  echo "STAR index exists, skipping build"
fi

echo ""
echo "Aligning reads to genome..."

# Align each sample
while IFS=',' read -r sample_id sra_id condition replicate fastq_1 fastq_2; do
  
  # Skip header line
  if [ "$sample_id" == "sample_id" ]; then
    continue
  fi
  
  echo "  Aligning ${sample_id}..."
  
  # Skip if already aligned
  if [ -f "${ALIGN_DIR}/${sample_id}_Aligned.sortedByCoord.out.bam" ]; then
    echo "    Already aligned, skipping"
    continue
  fi
  
  # Trimmed file names
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
    
done < data/metadata.csv

echo ""
echo "Indexing BAM files..."

# Index BAM files
for BAM in ${ALIGN_DIR}/*_Aligned.sortedByCoord.out.bam; do
  samtools index -@ ${THREADS} ${BAM}
done

echo ""
echo "Generating alignment statistics..."

# Create summary statistics
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
echo "========================================"
echo "Alignment Complete!"
echo "========================================"
echo ""
echo "BAM files: ${ALIGN_DIR}/*_Aligned.sortedByCoord.out.bam"
echo "Statistics: ${ALIGN_DIR}/alignment_stats.csv"
echo ""
echo "Alignment Summary:"
cat ${ALIGN_DIR}/alignment_stats.csv | column -t -s,
echo ""
echo "Expected metrics:"
echo "  - Uniquely mapped: >80%"
echo "  - Unmapped: <10%"
echo ""
echo "Next step: bash scripts/05_count_reads.sh"
