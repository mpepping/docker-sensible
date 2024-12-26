#!/bin/sh
# Get the IP address of the eth0 interface, e.g., 10.1.1.1

ip a s eth0 | awk '/inet / {print $2}' | cut -d/ -f1
