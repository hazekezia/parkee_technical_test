#!/bin/bash

log_file="/var/log/disk_usage.log"

#Threshold disk usage
threshold=80

#Token API Telegram dan chat ID
telegram_token=""
chat_id=""

send_telegram_notification() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$telegram_token/sendMessage" \
        -d chat_id="$chat_id" \
        -d text="$message"
}

check_disk_usage() {
    usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')
    echo "$usage"
}

while true; do
    disk_usage=$(check_disk_usage)

    if [ "$disk_usage" -gt "$threshold" ]; then
        message="Warning: Disk usage is at ${disk_usage}% on $(hostname)"
        send_telegram_notification "$message"

        echo "$(date) - High disk usage detected: ${disk_usage}%" >> "$log_file"
    else
        echo "Disk in normal usage."
    fi

    sleep 60
done