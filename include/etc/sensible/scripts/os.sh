#!/bin/sh
# Determine the operating system for the host system
#
# shellcheck disable=SC1091

# Return `PRETTY_NAME` from `os-release`
if [ -f /host/etc/os-release ]; then
    . /host/etc/os-release
    echo "$PRETTY_NAME"
    exit 0
elif [ -f /host/usr/lib/os-release ]; then
    . /host/usr/lib/os-release
    echo "$PRETTY_NAME"
    exit 0
elif [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$PRETTY_NAME"
    exit 0
else
    echo "Linux"
fi
