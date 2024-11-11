#!/bin/bash

#Parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

#Variable
PUBLIC_KEY_FILE=$1
USERNAME=$2

#Check if public key found
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "File $PUBLIC_KEY_FILE not found!"
    exit 1
fi

#Check if username exist
if ! id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME does not exist!"
    exit 1
fi

#Locate authorized_keys for user
AUTHORIZED_KEYS="/home/$USERNAME/.ssh/authorized_keys"

#Create .ssh directory
if [ ! -d "/home/$USERNAME/.ssh" ]; then
    mkdir -p "/home/$USERNAME/.ssh"
    chown "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
    chmod 700 "/home/$USERNAME/.ssh"
fi

#Add public key to authorized_keys
cat "$PUBLIC_KEY_FILE" >> "$AUTHORIZED_KEYS"

#Set permissions
chown "$USERNAME:$USERNAME" "$AUTHORIZED_KEYS"
chmod 600 "$AUTHORIZED_KEYS"

echo "Public key has been added to $AUTHORIZED_KEYS"
