#!/bin/bash

# Create a non-root user for remote desktop access
adduser --disabled-password --gecos "" amt && \
echo "amt:$DESKTOP_PASS" | chpasswd && \
adduser amt sudo

start_xrdp() {
    echo "XRDP service started."
    /usr/sbin/xrdp -n -f &
}

# start_jupyterlab() {
#     echo "Starting Jupyter Lab..."
#     jupyter lab --allow-root --no-browser --port=8888 --ip=* --FileContentsManager.delete_to_trash=False --ServerApp.token=$JUPYTER_PASSWORD --ServerApp.allow_origin=*
# }

start_xrdp

# Keep the container running indefinitely
tail -f /dev/null