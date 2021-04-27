FROM debian:10-slim

ENV DISPLAY=":0" \
    NODE_VERSION="14"

RUN apt-get update \
    && apt-get upgrade -y \
    \
    `# Tauri system dependencies` \
    && apt-get install -y libwebkit2gtk-4.0-dev build-essential mesa-utils curl wget libssl-dev appmenu-gtk3-module libgtk-3-dev squashfs-tools \
    \
    `# Node.js` \
    && (curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -) \
    && apt-get install -y nodejs \
    && npm install --unsafe-perm -g yarn @tauri-apps/cli \
    \
    `# Rust` \
    && (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y) \
    && . "$HOME/.cargo/env" \
    && rustup update stable \
    && cargo install tauri-bundler --force
