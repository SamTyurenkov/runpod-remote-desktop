#!/bin/bash

# Start the XRDP service
/usr/sbin/xrdp -n -f &

# Optionally, add additional setup steps here
echo "XRDP service started."

# Keep the container running indefinitely
tail -f /dev/null