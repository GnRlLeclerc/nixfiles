# Tauri development dockerfile
FROM archlinux:base-devel

# Install required dependencies
RUN pacman -Syu --noconfirm
RUN pacman -S --needed --noconfirm \
  webkit2gtk-4.1 \
  base-devel \
  curl \
  wget \
  file \
  openssl \
  appmenu-gtk-module \
  libappindicator-gtk3 \
  librsvg \
  unzip

# User arguments
ARG HOST_USER_ID
ARG HOST_USER_NAME
ARG HOST_GROUP_ID
ARG HOST_GROUP_NAME

# Create a non-root user identical to the current user to avoid messing up file permissions
# Note that we have to delete the group first if it is already defined to avoid group id being wrong
RUN groupdel $HOST_GROUP_NAME || true \
  && groupadd -f -g $HOST_GROUP_ID $HOST_GROUP_NAME \
  && useradd -m -d /home/$HOST_USER_NAME -s /bin/bash -g $HOST_GROUP_ID -u $HOST_USER_ID $HOST_USER_NAME || true \
  && echo "$HOST_USER_NAME  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the user
USER $HOST_USER_NAME

# Install rustup & rust for the user
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Install bun package manager
RUN curl -fsSL https://bun.sh/install | bash

# Use dark theme
ENV GTK_THEME=Adwaita:dark
# https://github.com/tauri-apps/tauri/issues/8929
ENV NO_STRIP=true

WORKDIR /home/$HOST_USER_NAME/development
