#!/bin/bash

#Parameter
if [ $# -ne 3 ]; then
    echo "Usage: $0 <source_file> <username> <server_ip>"
    exit 1
fi

#Variable
source_file=$1
username=$2
server_ip=$3

#Check if source file exist
if [ ! -f "$source_file" ]; then
    echo "Error: Source file '$source_file' does not exist."
    exit 1
fi

rsync -avz "$source_file" "$username@$server_ip:~/"

#Checkpoint
if [ $? -eq 0 ]; then
    echo "File '$source_file' successfully copied to $username@$server_ip:~/"
else
    echo "Failed to copy file '$source_file' to $username@$server_ip:~/"
fi
