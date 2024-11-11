#!/bin/bash

# Flush semua aturan yang ada
iptables -F

# Mengizinkan semua koneksi keluar
iptables -A OUTPUT -j ACCEPT

# Mengizinkan koneksi masuk ke port 22 (SSH), 80 (HTTP), dan 443 (HTTPS)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Menolak semua koneksi masuk lainnya
iptables -A INPUT -j REJECT
