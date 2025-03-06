#!/bin/bash

# Exit on error
set -e

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!" 1>&2
    exit 1
fi

# Update system package list
echo "Updating system packages..."
apt update

# Install dependencies
echo "Installing required dependencies..."
apt install -y \
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
ninja -C builddir install

# Clean up
cd ..
rm -rf hyprland-protocols

echo "Hyprland Protocols have been installed successfully!"
