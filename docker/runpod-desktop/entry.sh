#!/bin/bash

# Create a non-root user for remote desktop access
adduser --disabled-password --gecos "" amt && \
echo "amt:$DESKTOP_PASS" | chpasswd && \
adduser amt sudo

# Configure VNC to start XFCE for the user
su - amt -c "mkdir -p ~/.vnc"
su - amt -c "echo '#!/bin/sh
xrdb $HOME/.Xresources
startxfce4 &' > ~/.vnc/xstartup"
su - amt -c "chmod +x ~/.vnc/xstartup"

# Start TigerVNC server on display :1
su - amt -c "vncserver :1 -geometry 1920x1080 -depth 24 -localhost no"

# Start noVNC web server on port 8080, proxying to the VNC server
websockify --web=/usr/share/novnc/ 8080 localhost:5901 &

# Keep the container running indefinitely
tail -f /dev/null
