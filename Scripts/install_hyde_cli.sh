#!/bin/bash

set -e  # Exit on error
set -o pipefail  # Catch pipeline errors

REPO_URL="https://github.com/HyDE-Project/Hyde-cli.git"
INSTALL_DIR="$HOME/Hyde-cli"

echo "Updating package lists and installing dependencies..."
sudo apt update
sudo apt install -y git make build-essential

# Clone the repository
echo "Cloning the Hyde-cli repository..."
git clone "$REPO_URL" "$INSTALL_DIR"

cd "$INSTALL_DIR"

# Run make
echo "Running 'make' to build Hyde-cli..."
sudo make

# Cleanup the cloned directory
echo "Cleaning up the installation directory..."
cd ~
rm -rf "$INSTALL_DIR"

echo "Hyde-cli installation complete and directory cleaned up!"
