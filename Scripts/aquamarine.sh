#!/bin/bash

# Define variables
REPO_URL="https://github.com/hyprwm/aquamarine.git"
BUILD_DIR="build"
INSTALL_PREFIX="/usr"
BUILD_TYPE="Release"

sudo apt install wayland-protocols

# Clone the repository
echo "Cloning the repository..."
git clone "$REPO_URL" || { echo "Failed to clone repository"; exit 1; }

# Navigate into the cloned repository
cd aquamarine || { echo "Failed to enter directory"; exit 1; }

# Configure the build
echo "Configuring the build..."
cmake -S . -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
    --no-warn-unused-cli || { echo "CMake configuration failed"; exit 1; }

# Build the project
echo "Building the project..."
cmake --build "$BUILD_DIR" --config "$BUILD_TYPE" --target all -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF) || { echo "Build failed"; exit 1; }

echo "Installing the project..."
sudo cmake --install ./$BUILD_DIR

echo "Build and configuration completed successfully!"
