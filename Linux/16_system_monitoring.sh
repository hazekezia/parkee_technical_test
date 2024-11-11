#!/bin/bash

#hostname
hostname=$(hostname)

#time
current_time=$(date)

#user count
user_count=$(who | wc -l)

echo "System Information:"
echo "Hostname: $hostname"
echo "Current Time: $current_time"
echo "Number of Users Logged In: $user_count"
