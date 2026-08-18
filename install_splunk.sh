#!/bin/bash

#======================
# Splunk Installation
#======================

echo "================================"
echo "Starting Splunk installation"
echo "================================"

# Variables
SPLUNK_URL="https://download.splunk.com/products/splunk/releases/9.3.0/linux/splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb"
SPLUNK_DEB="splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb"
SPLUNK_DIR="/opt/splunk/bin"

# Check for and wait on a locked dpkg frontend
if sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; then
    echo "[!] dpkg is in use by another process, waiting..."
    while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
        sleep 2
    done
fi

# Download Splunk
echo "[+] Downloading Splunk..."
wget -O "$SPLUNK_DEB" "$SPLUNK_URL"

# Verify the file was downloaded
if [ -f "$SPLUNK_DEB" ]; then
    echo "[+] File downloaded successfully"
else
    echo "[-] Error: Splunk file was not downloaded."
    exit 1
fi

# Install Splunk
echo "[+] Installing Splunk"
sudo dpkg -i "$SPLUNK_DEB"

# Check if dpkg reported errors (e.g. missing dependencies) and fix them
if [ $? -ne 0 ]; then
    echo "[!] dpkg reported errors, attempting to resolve dependencies..."
    sudo apt-get install -f -y
fi

# Verify Splunk was installed
if [ -d "$SPLUNK_DIR" ]; then
    echo "[+] Splunk installed successfully"
else
    echo "[-] Error: Splunk was not installed correctly"
    exit 1
fi

# Splunk directory
cd "$SPLUNK_DIR" || exit 1

# Enable it as a service
echo "[+] Enabling Splunk to start on boot"
sudo ./splunk enable boot-start --accept-license

# Start Splunk
echo "[+] Starting Splunk"
sudo ./splunk start

# Final message
echo "================================"
echo "Splunk installed and running"
echo "================================"


