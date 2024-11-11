#!/bin/bash

#Parameter
if [ $# -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <server_ip>"
    exit 1
fi

#Variable
PUBLIC_KEY_FILE=$1
USERNAME=$2
SERVER_IP=$3

#Check public key
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: Public key file '$PUBLIC_KEY_FILE' not found."
    exit 1
fi

#Copy the public key to the authorized_keys on the remote server
ssh "$USERNAME@$SERVER_IP" "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < "$PUBLIC_KEY_FILE"

#Set permissions
ssh "$USERNAME@$SERVER_IP" "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

echo "Public key has been copied to $USERNAME@$SERVER_IP."
