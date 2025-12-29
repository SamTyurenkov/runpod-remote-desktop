#!/bin/bash

# Create a non-root user for remote desktop access
echo "amt:$DESKTOP_PASS" | chpasswd && \
adduser amt sudo

# Add desktop shortcuts for Google Chrome, Telegram, Logs and File Manager
mkdir -p /home/amt/Desktop

chown amt:amt /home/amt/Desktop/*.desktop
chmod +x /home/amt/Desktop/*.desktop

xpra start :100 --start="google-chrome --no-sandbox --disable-dev-shm-usage --disable-gpu --disable-software-rasterizer --disable-features=VizDisplayCompositor" --bind-tcp=0.0.0.0:14500 --html=on &
xpra start :101 --start=telegram-desktop --bind-tcp=0.0.0.0:14501 --html=on &
tail -f /dev/null
