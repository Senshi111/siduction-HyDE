#!/bin/bash

sudo apt install libpugixml-dev


# Clone the hyprwayland-scanner repository
echo "Cloning hyprwayland-scanner repository..."
git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner


cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`

sudo cmake --install build