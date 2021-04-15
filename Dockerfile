FROM debian:latest

ENV DISPLAY=":0"

RUN apt-get update \
    && apt-get upgrade -y \
    \
    `# Tauri system dependencies` \
    && apt-get install -y libwebkit2gtk-4.0-dev build-essential curl wget libssl-dev appmenu-gtk3-module libgtk-3-dev squashfs-tools \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
    \
    `# Node.js` \
    && export NVM_DIR="$HOME/.nvm" \
    && . "$NVM_DIR/nvm.sh" \
    && . "$NVM_DIR/bash_completion" \
    && nvm install node --latest-npm \
    && nvm use node \
    && npm install -g yarn \
    \
    `# Rust` \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . "$HOME/.cargo/env" \
    && rustup update stable \
    && cargo install tauri-bundler --force \
    && cargo install tauri-cli --force

