#!/bin/bash

# Script to install rofi-wayland

# Update the package list
echo "Updating package list..."
sudo apt update

# Install necessary dependencies
echo "Installing required dependencies..."
sudo apt install -y \
  build-essential \
  git \
  cmake \
  libfl-dev \
  libbison-dev \
  pkg-config \
  meson \
  ninja-build \
  wayland-protocols \
  libwayland-dev \
  libxkbcommon-dev \
  libevdev-dev \
  libxcb-xkb-dev \
  libxcb-randr0-dev \
  libxcb-util0-dev \
  libxcb-cursor-dev \
  libxcb-xinerama0-dev \
  libstartup-notification0-dev \
  libglib2.0-dev \
  libpango1.0-dev \
  libgdk-pixbuf2.0-dev \
  libpixman-1-dev \
  libx11-dev

# Clone the rofi-wayland repository
echo "Cloning rofi-wayland repository..."
git clone https://github.com/in0ni/rofi-wayland.git
cd rofi-wayland

# Build the project using meson and ninja
echo "Building rofi-wayland..."
meson setup build
ninja -C build

# Install rofi-wayland
echo "Installing rofi-wayland..."
sudo ninja -C build install

# Remove the cloned repository folder
echo "Cleaning up by removing the cloned repository folder..."
cd ..
rm -rf rofi-wayland

# Confirm the installation
echo "rofi-wayland has been successfully installed and the repository folder has been removed."
