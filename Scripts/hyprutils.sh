#!/bin/bash

# Clone the repository
git clone https://github.com/hyprwm/hyprutils.git
if [ $? -ne 0 ]; then
  echo "Failed to clone the repository."
  exit 1
fi

# Navigate to the repository directory
cd hyprutils/ || exit

# Run CMake configuration
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
if [ $? -ne 0 ]; then
  echo "CMake configuration failed."
  exit 1
fi

# Build the project
cmake --build ./build --config Release --target all -j$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)
if [ $? -ne 0 ]; then
  echo "Build process failed."
  exit 1
fi

# Install the built project
sudo cmake --install build
if [ $? -ne 0 ]; then
  echo "Installation failed."
  exit 1
fi

echo "Build and installation completed successfully."
