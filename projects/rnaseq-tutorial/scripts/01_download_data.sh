#!/bin/bash
# 01_download_data.sh
# Downloads RNA-seq data from GEO accession GSE79018
# Usage: bash 01_download_data.sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "Starting data download for GSE79018"
echo ""

# Create directories
mkdir -p data/raw
mkdir -p data/reference
mkdir -p results/qc

# SRA accessions for GSE79018 (Control and Dnmt1 KO samples)
SRA_IDS=(
  "SRR3212794"
  "SRR3212795"
  "SRR3212796"
  "SRR3212797"
)

# Download FASTQ files
echo "Downloading FASTQ files from SRA..."
for SRA_ID in "${SRA_IDS[@]}"; do
  
  # Skip if already downloaded
  if [ -f "data/raw/${SRA_ID}_1.fastq.gz" ] && [ -f "data/raw/${SRA_ID}_2.fastq.gz" ]; then
    echo "  ${SRA_ID} - already exists, skipping"
    continue
  fi
  
  echo "  Downloading ${SRA_ID}..."
  
  # Download using fasterq-dump (faster than fastq-dump)
  fasterq-dump ${SRA_ID} \
    --outdir data/raw \
    --threads 4 \
    --split-files
    
  # Compress FASTQ files
  gzip data/raw/${SRA_ID}_1.fastq
  gzip data/raw/${SRA_ID}_2.fastq
done

echo ""
echo "Downloading reference genome..."

cd data/reference

# Download mouse reference genome (GRCm39)
if [ ! -f "Mus_musculus.GRCm39.dna.primary_assembly.fa" ]; then
  wget https://ftp.ensembl.org/pub/release-115/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
  gunzip Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
else
  echo "  Reference genome already exists"
fi

# Download gene annotation (GTF)
if [ ! -f "Mus_musculus.GRCm39.115.gtf" ]; then
  wget https://ftp.ensembl.org/pub/release-115/gtf/mus_musculus/Mus_musculus.GRCm39.115.gtf.gz
  gunzip Mus_musculus.GRCm39.115.gtf.gz
else
  echo "  Gene annotation already exists"
fi

cd ../..

echo ""
echo "Creating sample metadata..."

# Create metadata file
cat > data/metadata.csv << 'EOF'
sample_id,sra_id,condition,replicate,fastq_1,fastq_2
Control_1,SRR3212794,Control,1,data/raw/SRR3212794_1.fastq.gz,data/raw/SRR3212794_2.fastq.gz
Control_2,SRR3212795,Control,2,data/raw/SRR3212795_1.fastq.gz,data/raw/SRR3212795_2.fastq.gz
Dnmt1_KO_1,SRR3212797,Dnmt1_KO,1,data/raw/SRR3212797_1.fastq.gz,data/raw/SRR3212797_2.fastq.gz
Dnmt1_KO_2,SRR3212798,Dnmt1_KO,2,data/raw/SRR3212798_1.fastq.gz,data/raw/SRR3212798_2.fastq.gz
EOF

echo ""
echo "========================================"
echo "Data download complete!"
echo "========================================"
echo ""
echo "Downloaded:"
echo "  - 4 samples (2 Control, 2 Dnmt1 KO)"
echo "  - Mouse reference genome (GRCm39)"
echo "  - Gene annotation (Ensembl 115)"
echo ""
echo "Next step: bash scripts/02_quality_control.sh"
