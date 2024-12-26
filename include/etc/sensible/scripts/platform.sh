#!/bin/sh
# Determine the virtualization platform and format the output

# Run the virt-what command and format the output
PLATFORM=$(/usr/sbin/virt-what | tr '\n' '-')

# Remove the trailing hyphen
PLATFORM=${PLATFORM%-}

echo "$PLATFORM"
