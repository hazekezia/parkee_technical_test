#!/bin/bash

#Parameter
if [ $# -ne 2 ]; then
    echo "Usage: $0 <action> <service_name>"
    echo "Actions: start, stop, status"
    exit 1
fi

#Variable
action=$1
service_name=$2

case $action in
    start)
        sudo systemctl start "$service_name"
        if [ $? -eq 0 ]; then
            echo "Service '$service_name' started successfully."
        else
            echo "Failed to start service '$service_name'."
        fi
        ;;
    stop)
        sudo systemctl stop "$service_name"
        if [ $? -eq 0 ]; then
            echo "Service '$service_name' stopped successfully."
        else
            echo "Failed to stop service '$service_name'."
        fi
        ;;
    status)
        sudo systemctl status "$service_name"
        ;;
    *)
        echo "Invalid action. Use start, stop, or status."
        exit 1
        ;;
esac