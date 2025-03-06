#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Clone the repository
echo "Cloning xdg-desktop-portal-hyprland repository..."
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland

# Navigate to the repository directory
cd xdg-desktop-portal-hyprland/

# Generate build system with cmake
echo "Configuring build system..."
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build

# Build the project
echo "Building the project..."
cmake --build build

# Install the project
echo "Installing the project (requires sudo)..."
sudo cmake --install build

echo "Installation complete!"
