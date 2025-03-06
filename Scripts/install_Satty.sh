#!/bin/bash

# Function to check if the previous command was successful
check_command_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed!"
        exit 1
    fi
}

# Update and install necessary dependencies
echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y libsdbus-c++-dev libhyprlang-dev
check_command_success "Dependency installation"

# Clone the hypridle repository
echo "Cloning the Satty repository..."
git clone https://github.com/gabm/Satty.git
check_command_success "Git clone"

cd Satty || { echo "Error: Unable to enter the Satty directory"; exit 1; }

# Build the release binary
echo "Building the release binary..."
make build-release
check_command_success "Build release"

# Optionally, install to /usr/local
read -p "Do you want to install to /usr/local? (y/N): " install_choice
if [[ "$install_choice" == "y" || "$install_choice" == "Y" ]]; then
    echo "Installing to /usr/local..."
    PREFIX=/usr/local make install
    check_command_success "Install to /usr/local"
fi

# Optionally, uninstall from /usr/local
read -p "Do you want to uninstall from /usr/local? (y/N): " uninstall_choice
if [[ "$uninstall_choice" == "y" || "$uninstall_choice" == "Y" ]]; then
    echo "Uninstalling from /usr/local..."
    PREFIX=/usr/local make uninstall
    check_command_success "Uninstall from /usr/local"
fi

echo "Script completed successfully."
