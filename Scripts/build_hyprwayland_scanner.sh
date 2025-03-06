#!/bin/bash

# Define variables
REPO_URL="https://github.com/hyprwm/hyprwayland-scanner.git"
INSTALL_PREFIX="/usr"
BUILD_DIR="build"

# Function to check for command success
check_success() {
  if [ $? -ne 0 ]; then
    echo "Error occurred: $1"
    exit 1
  fi
}

# Step 1: Clone the repository
echo "Cloning repository from $REPO_URL..."
git clone "$REPO_URL"
check_success "Failed to clone the repository."

# Navigate into the repository folder
REPO_NAME=$(basename "$REPO_URL" .git)
cd "$REPO_NAME" || exit
echo "Navigated to $(pwd)."

# Step 2: Run CMake commands
echo "Running CMake configuration..."
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -B $BUILD_DIR
check_success "CMake configuration failed."

echo "Building the project..."
cmake --build $BUILD_DIR -j $(nproc)
check_success "Build process failed."

# Step 3: Install the build
echo "Installing the project..."
sudo cmake --install $BUILD_DIR
check_success "Installation process failed."

echo "Hyprwayland Scanner built and installed successfully!"
