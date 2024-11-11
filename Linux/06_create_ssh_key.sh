#!/bin/bash

#Parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

#Variable
key_directory=$1

#Check if directory exist
if [ ! -d "$key_directory" ]; then
    echo "Directory '$key_directory' does not exist. Creating it now..."
    mkdir -p "$key_directory"
fi

#Define SSH path
key_path="$key_directory/id_rsa"

#Generate SSH key
ssh-keygen -t rsa -b 4096 -f "$key_path" -N ""

#Checkpoint
if [ $? -eq 0 ]; then
    echo "SSH key pair generated successfully!"
    echo "Private key: $key_path"
    echo "Public key: $key_path.pub"
else
    echo "Failed to generate SSH key pair."
fi
