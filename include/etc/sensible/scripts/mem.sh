#!/bin/sh
# Determine used memory in percentage

# Read memory information from /proc/meminfo
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_AVAILABLE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

# Calculate used memory
MEM_USED=$((MEM_TOTAL - MEM_AVAILABLE))

# Calculate used memory percentage
MEM_USED_PERCENT=$(echo "$MEM_USED $MEM_TOTAL" | awk '{printf "%.2f", ($1 / $2) * 100}')

echo "$MEM_USED_PERCENT"
