#!/bin/bash

#Parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

#Variable
source_directory=$1
backup_directory=$2

#Check if source directory exist
if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory '$source_directory' does not exist."
    exit 1
fi

#Check if backup directory exist
if [ ! -d "$backup_directory" ]; then
    echo "Backup directory '$backup_directory' does not exist. Creating it now..."
    mkdir -p "$backup_directory"
fi

#Timestamp
timestamp=$(date +%Y%m%d_%H%M%S)

#Backup name
backup_filename=$(basename "$source_directory")_backup_$timestamp.tar.gz

#Backup start
tar -czf "$backup_directory/$backup_filename" -C "$source_directory" .

#Checkpoint
if [ $? -eq 0 ]; then
    echo "Backup successful! File saved as $backup_directory/$backup_filename"
else
    echo "Backup failed."
    exit 1
fi

#Delete old backup
find "$backup_directory" -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;

echo "Old backups older than 7 days have been removed."
