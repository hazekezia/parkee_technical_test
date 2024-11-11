#!/bin/bash

#Parameter
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_python_script>"
    exit 1
fi

#Variable
python_script=$1

#Check python scriptp
if [ ! -f "$python_script" ]; then
    echo "Error: Python script '$python_script' does not exist."
    exit 1
fi

#Create systemd service
service_name="simple_python_service.service"
service_file="/etc/systemd/system/$service_name"

#systemd service config
cat <<EOL > "$service_file"
[Unit]
Description=Simple Python Script Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 $python_script
Restart=always
User=$USER
WorkingDirectory=$(dirname $python_script)
StandardOutput=append:/home/$USER/script.log
StandardError=append:/home/$USER/script.log

[Install]
WantedBy=multi-user.target
EOL

#Set permission
sudo chmod 644 "$service_file"

sudo systemctl daemon-reload

sudo systemctl enable "$service_name"
sudo systemctl start "$service_name"

#Check if service is running
sudo systemctl status "$service_name"