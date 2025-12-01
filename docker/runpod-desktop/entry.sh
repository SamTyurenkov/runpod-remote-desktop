#!/bin/bash

# Create a non-root user for remote desktop access
adduser --disabled-password --gecos "" amt && \
echo "amt:$DESKTOP_PASS" | chpasswd && \
adduser amt sudo

# Configure VNC to start XFCE for the user
su - amt -c "mkdir -p ~/.vnc"
su - amt -c "printf '%s\n%s\nn\n' \"$DESKTOP_PASS\" \"$DESKTOP_PASS\" | vncpasswd"

cat >/home/amt/.vnc/xstartup << 'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
if [ -x /usr/bin/startxfce4 ]; then
  exec /usr/bin/startxfce4
else
  exec /usr/bin/xterm
fi
EOF

chown amt:amt /home/amt/.vnc/xstartup
chmod +x /home/amt/.vnc/xstartup

# Start TigerVNC server on display :1
su - amt -c "vncserver :1 -depth 24 -localhost no"

# Start noVNC web server on port 8080, proxying to the VNC server
websockify --web=/usr/share/novnc/ 8080 localhost:5901 &

# Keep the container running indefinitely
tail -f /dev/null
