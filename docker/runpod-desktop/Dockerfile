# Base image with Linux Mint
FROM debian:bookworm-slim

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y xpra xvfb x11-xserver-utils fluxbox

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# Install Telegram Desktop using official binary (no PPA/package needed)
RUN wget -O /tmp/tdesktop.tar.xz "https://telegram.org/dl/desktop/linux" && \
    mkdir -p /opt/telegram && \
    tar -xJf /tmp/tdesktop.tar.xz -C /opt/telegram --strip-components=1 && \
    ln -s /opt/telegram/Telegram /usr/local/bin/telegram-desktop && \
    rm /tmp/tdesktop.tar.xz

RUN adduser --disabled-password --gecos "" amt

# Expose ports
EXPOSE 14500
EXPOSE 14501


ADD entry.sh /usr/local/bin/entrypoint.sh
WORKDIR /
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]