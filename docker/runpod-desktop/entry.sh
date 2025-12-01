#!/bin/bash

# Create a non-root user for remote desktop access
adduser --disabled-password --gecos "" amt && \
echo "amt:$DESKTOP_PASS" | chpasswd && \
adduser amt sudo

# Add desktop shortcuts for Google Chrome, Telegram, Logs and File Manager
mkdir -p /home/amt/Desktop

cat >/home/amt/Desktop/chrome.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Google Chrome
Exec=google-chrome --no-sandbox --disable-dev-shm-usage
Terminal=false
Icon=google-chrome
Categories=Network;WebBrowser;
EOF

cat >/home/amt/Desktop/telegram.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Telegram
Exec=telegram-desktop
Terminal=false
Icon=telegram
Categories=Network;InstantMessaging;
EOF

cat >/home/amt/Desktop/files.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=File Manager
Exec=nemo
Terminal=false
Icon=system-file-manager
Categories=Utility;FileManager;
EOF

chown amt:amt /home/amt/Desktop/*.desktop
chmod +x /home/amt/Desktop/*.desktop

# Configure VNC to start XFCE for the user
su - amt -c "mkdir -p ~/.vnc"
su - amt -c "printf '%s\n%s\nn\n' \"$DESKTOP_PASS\" \"$DESKTOP_PASS\" | vncpasswd"

cat >/home/amt/.vnc/xstartup << 'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
if [ -x /usr/bin/cinnamon-session ]; then
  exec /usr/bin/cinnamon-session
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
