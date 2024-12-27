#!/bin/sh
# Determine the free space on the root partition in GB

df / | tail -n 1 | awk '/ / {printf "%.2f", $4 / 1048576}'
