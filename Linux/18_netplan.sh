#!/bin/bash

#File konfigurasi netplan untuk interface eth0
NETPLAN_CONFIG_FILE="/etc/netplan/netplan.yaml"

#Membuat konfigurasi netplan untuk eth0
echo "network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4" > $NETPLAN_CONFIG_FILE

#Menerapkan konfigurasi netplan
netplan apply

#Menampilkan status jaringan
echo "Jaringan telah dikonfigurasi dengan IP: 192.168.1.100, Gateway: 192.168.1.1, DNS: 8.8.8.8, 8.8.4.4"
