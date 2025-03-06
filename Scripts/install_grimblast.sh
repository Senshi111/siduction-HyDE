#!/bin/bash

set -e  # Exit on error
set -o pipefail  # Catch pipeline errors

REPO_URL="https://github.com/hyprwm/contrib.git"


echo "Updating package lists and installing dependencies..."
sudo apt update
sudo apt install -y grim slurp wl-clipboard gcc make git scdoc

# Clone and build Grimblast
echo "Cloning Grimblast repository..."
git clone --depth=1 "$REPO_URL"

cd contrib/grimblast

echo "Compiling Grimblast..."
make

echo "Installing Grimblast..."
sudo make install

# Cleanup
echo "Cleaning up temporary files..."
cd ~


echo "Installation complete! Run 'grimblast' to test."
