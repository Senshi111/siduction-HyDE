#!/bin/bash

# Script to clone and install Grimblast from the contrib repository

# Exit immediately if a command exits with a non-zero status
set -e

# Define the repository URL and directory
REPO_URL="https://github.com/hyprwm/contrib.git"
CLONE_DIR="contrib"

# Clone the repository if it doesn't exist
if [ ! -d "$CLONE_DIR" ]; then
    echo "Cloning repository from $REPO_URL..."
    git clone "$REPO_URL"
else
    echo "Repository already cloned. Pulling latest changes..."
    cd "$CLONE_DIR"
    git pull
    cd ..
fi

# Change to the Grimblast directory
echo "Navigating to Grimblast directory..."
cd "$CLONE_DIR/grimblast"

# Compile the project
echo "Building Grimblast..."
make

# Install the project
echo "Installing Grimblast (requires sudo)..."
sudo make install

# Success message
echo "Grimblast installed successfully!"
