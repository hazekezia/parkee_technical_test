#!/bin/bash

#Parameter
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string> <username>"
    exit 1
fi

#Variable
UNIQUE_STRING=$1
USERNAME=$2

#Check if username exist
if ! id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME does not exist!"
    exit 1
fi

#Locate authorized_keys for user
AUTHORIZED_KEYS="/home/$USERNAME/.ssh/authorized_keys"

#Check if authorized_keys exits
if [ ! -f "$AUTHORIZED_KEYS" ]; then
    echo "File $AUTHORIZED_KEYS not found!"
    exit 1
fi

#Delete key with unique string
sed -i.bak "/$UNIQUE_STRING/d" "$AUTHORIZED_KEYS"

#Set permissions
chown "$USERNAME:$USERNAME" "$AUTHORIZED_KEYS"
chmod 600 "$AUTHORIZED_KEYS"

echo "Public key containing the string '$UNIQUE_STRING' has been removed from $AUTHORIZED_KEYS"
