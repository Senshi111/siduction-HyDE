#!/bin/bash

set -e  # Exit on error

#!/bin/bash

# Script to build and package uwsm into a Debian package

# Variables
PACKAGE_NAME="uwsm"
VERSION="1.0"
BUILD_DIR="build"
DEBIAN_DIR="debian"

# Step 1: Install required dependencies
# echo "Installing required dependencies..."
# sudo apt-get update
# sudo apt-get install -y git build-essential devscripts debhelper dh-make meson ninja-build

# Step 2: Clone the repository (if not already cloned)
if [ ! -d "$PACKAGE_NAME" ]; then
    echo "Cloning the repository..."
    git clone https://github.com/Vladimir-csp/uwsm.git
    cd uwsm
else
    echo "Repository already cloned. Continuing..."
    cd uwsm
fi

# Step 3: Build the project with Meson
echo "Building the project with Meson..."
meson setup --prefix=/usr/local -Duuctl=enabled -Dfumon=enabled -Duwsm-app=enabled build
meson install -C build


echo "Done! The Debian package has been built and installed."
