#!/bin/bash

# Check if directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/sequence_directory"
    exit 1
fi

# Resolve absolute path of the sequence directory
SEQ_DIR=$(realpath "$1")
MANIFEST_FILE="$SEQ_DIR/manifest.csv"

# QIIME 2 manifest file header
echo "sample-id,absolute-filepath,direction" > "$MANIFEST_FILE"

# Loop through FASTQ files
for file in "$SEQ_DIR"/*.fastq.gz; do
    # Extract absolute file path
    abs_file_path=$(realpath "$file")

    # Extract sample ID (first part before first underscore)
    filename=$(basename "$file" .fastq.gz)
    sample_id="${filename%%_*}"  # Extract substring before first underscore

    # Append entry to manifest file
    echo "$sample_id,$abs_file_path,forward" >> "$MANIFEST_FILE"
done

echo "Manifest file created: $MANIFEST_FILE"
