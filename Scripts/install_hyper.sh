#!/bin/bash

set -e  # Exit on error

HYPER_DEB_URL="https://releases.hyper.is/download/deb"
TEMP_DEB="/tmp/hyper.deb"

# Check for required dependencies
if ! command -v curl &> /dev/null; then
    echo "Error: curl is not installed. Install it using: sudo apt install curl"
    exit 1
fi

if ! command -v dpkg &> /dev/null; then
    echo "Error: dpkg is not installed. Install it using: sudo apt install dpkg"
    exit 1
fi

# Download the latest Hyper .deb package
echo "Downloading Hyper..."
curl -L "$HYPER_DEB_URL" -o "$TEMP_DEB"

# Install Hyper
echo "Installing Hyper..."
sudo dpkg -i "$TEMP_DEB"

# Fix missing dependencies (if any)
sudo apt-get install -f -y

# Clean up
rm -f "$TEMP_DEB"

echo "Hyper installation complete! You can launch it by running: hyper"
