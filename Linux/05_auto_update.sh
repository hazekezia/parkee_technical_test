#!/bin/bash

#Parameter
log_file="/var/log/system_update_$(date +%Y%m%d_%H%M%S).log"

#Check OS
if command -v apt > /dev/null; then
    package_manager="apt"
elif command -v yum > /dev/null; then
    package_manager="yum"
else
    echo "No supported package manager found (apt or yum)." | tee -a "$log_file"
    exit 1
fi

echo "Starting system update using $package_manager at $(date)" | tee -a "$log_file"

case $package_manager in
    apt)
        sudo apt update | tee -a "$log_file"
        sudo apt upgrade -y | tee -a "$log_file"
        ;;
    yum)
        sudo yum update -y | tee -a "$log_file"
        ;;
esac

#Log
echo "System update completed at $(date)" | tee -a "$log_file"

echo "Log file saved at $log_file"
