#!/bin/bash

# Exit on error
set -e


# Update system package list
echo "Updating system packages..."
sudo apt update

# Install dependencies
echo "Installing required dependencies..."
sudo apt install -y \
    build-essential \
    git \
    meson \
    ninja-build \
    pkg-config \
    libwayland-dev \
    libxkbcommon-dev \
    libudev-dev \
    libsystemd-dev \
    libegl1-mesa-dev \
    libinput-dev \
    libpixman-1-dev

# Clone the Hyprland Protocols repository
echo "Cloning the Hyprland Protocols repository..."
git clone https://github.com/hyprwm/hyprland-protocols.git
cd hyprland-protocols

# Build the project using Meson and Ninja
echo "Building the project..."
meson setup builddir
ninja -C builddir

# Install the project
echo "Installing Hyprland Protocols..."
sudo ninja -C builddir install

# Clean up
cd ..
rm -rf hyprland-protocols

echo "Hyprland Protocols have been installed successfully!"
