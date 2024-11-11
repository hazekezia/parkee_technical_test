#!/bin/bash

#Parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <server_ip>"
    exit 1
fi

#Variable
USERNAME=$1
SERVER_IP=$2

#SSH Connect
ssh -o ConnectTimeout=5 "$USERNAME@$SERVER_IP" "exit" &> /dev/null

#Checkpoint
if [ $? -eq 0 ]; then
    echo "Connection to $USERNAME@$SERVER_IP was successful."
else
    echo "Connection to $USERNAME@$SERVER_IP failed."
fi