# Base image with Linux Mint
FROM linuxmintd/mint22.2-amd64

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    cinnamon \
    cinnamon-core \
    xed \
    sudo \
    wget \
    curl \
    nano \
    dbus-x11 \
    libu2f-udev \
    libvulkan1 \
    libva-drm2 \
    libva-x11-2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    ca-certificates \
    novnc \
    websockify \
    tigervnc-standalone-server \
    tigervnc-tools \
    --no-install-recommends

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# Install Telegram Desktop
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:atareao/telegram && \
    apt-get update && \
    apt-get install -y telegram

# Allow any user to start the X server
RUN echo "allowed_users=anybody" > /etc/X11/Xwrapper.config

# RUN pip install --upgrade pip && pip install jupyter ninja

# Expose noVNC port
EXPOSE 8080

ADD entry.sh /usr/local/bin/entrypoint.sh
WORKDIR /
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]