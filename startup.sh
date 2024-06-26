#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or using sudo"
    exit 1
fi

# Start snapd service
systemctl enable snap.apparmor
systemctl start snapd.service
echo You can use snap application
# Change MAC address (replace eth0 with your network interface)
ifconfig wlan0 down
macchanger -r wlan0
ifconfig wlan0 up
echo you are good to browsers

# Start Bluetooth service
service bluetooth start

# Snap install the application (replace 'app' with the actual application name)p

# Exit superuser mode
exit
