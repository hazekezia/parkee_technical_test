#!/bin/bash

#Parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

#Variable
source_directory=$1
backup_destination=$2

#Check if directory exist
if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory '$source_directory' does not exist."
    exit 1
fi

#Timestamp
timestamp=$(date +%Y%m%d_%H%M%S)

#Backup name
backup_filename=$(basename "$source_directory")_backup_$timestamp.tar.gz

#Backup start
tar -czf "$backup_destination/$backup_filename" -C "$source_directory" .

#Checkpoint
if [ $? -eq 0 ]; then
    echo "Backup successful! File saved as $backup_destination/$backup_filename"
else
    echo "Backup failed."
fi
