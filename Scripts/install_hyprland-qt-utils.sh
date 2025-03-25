#!/bin/bash

sudo apt install libsdbus-c++-dev libhyprlang-dev


# Clone the hypridle repository
echo "Cloning hypridle repository..."
git clone https://github.com/hyprwm/hyprland-qtutils.git
cd hyprland-qtutils


cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`

sudo cmake --install build