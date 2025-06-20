#!/bin/bash

echo "[+] Setting up Reconator..."

# Install required tools
sudo apt update
sudo apt install -y whois dnsutils dnsrecon curl whatweb wafw00f dig nslookup

# Make reconator.sh executable
chmod 700 reconator.sh

echo "[✓] Setup complete. Run the tool with: ./reconator.sh"
