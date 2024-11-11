#!/bin/bash

log_file="/var/log/cpu_usage.log"

#Threshold CPU usage
threshold=75

check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "$cpu_usage"
}

while true; do
    usage=$(check_cpu_usage)

    if (( $(echo "$usage > $threshold" | bc -l) )); then
        echo "$(date) - High CPU usage detected: $usage%" >> "$log_file"
    fi

    sleep 60
done
