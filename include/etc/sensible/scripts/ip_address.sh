#!/bin/sh
# Determine interface name and return IP address

# Get the first non-loopback interface name
INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')

# Get the IP address of the determined interface
IP_ADDRESS=$(ip a s "$INTERFACE" | awk '/inet / {print $2}' | cut -d/ -f1)

echo "$IP_ADDRESS"
