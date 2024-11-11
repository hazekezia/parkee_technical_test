#!/bin/bash

#Parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <file_extension>"
    exit 1
fi

#Variable
directory=$1
extension=$2

#Check if directory exist
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

#Print output
echo "Files with .$extension extension in directory $directory:"
find "$directory" -type f -name "*.$extension"
