#!/bin/sh
# Read the 1-minute load average from /host/proc/loadavg
LOAD_AVG=$(awk '{print $1}' /host/proc/loadavg)

# Get the number of CPU cores
CPU_CORES=$(nproc)

# Calculate the CPU utilization percentage
CPU_UTILIZATION=$(echo "$LOAD_AVG $CPU_CORES" | awk '{printf "%.2f", ($1 / $2) * 100}')

echo "$CPU_UTILIZATION%"
