#!/bin/bash

#Parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

#Variable
directory=$1

#Check if directory exist
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

#Output
printf "%-20s %-10s %-10s %-10s\n" "Filename" "Lines" "Words" "Characters"
printf "%-20s %-10s %-10s %-10s\n" "--------" "-----" "-----" "----------"

#Search Loop
for file in "$directory"/*.txt; do
    if [ -f "$file" ]; then
        counts=$(wc "$file")
        
        lines=$(echo $counts | awk '{print $1}')
        words=$(echo $counts | awk '{print $2}')
        chars=$(echo $counts | awk '{print $3}')
        filename=$(basename "$file")
        
        printf "%-20s %-10s %-10s %-10s\n" "$filename" "$lines" "$words" "$chars"
    fi
done
