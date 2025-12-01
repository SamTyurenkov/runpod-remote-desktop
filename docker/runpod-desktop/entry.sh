#!/bin/bash

# Start the XRDP service
/usr/sbin/xrdp -n -f &

# Optionally, add additional setup steps here
echo "XRDP service started."

# Create a non-root user for remote desktop access
adduser --disabled-password --gecos "" amt && \
echo "amt:$DESKTOP_PASS" | chpasswd && \
adduser amt sudo

# Keep the container running indefinitely
tail -f /dev/null