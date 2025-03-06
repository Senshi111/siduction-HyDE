#!/bin/bash

sudo apt install libsdbus-c++-dev libhyprlang-dev


# Clone the hypridle repository
echo "Cloning hypridle repository..."
git clone https://github.com/hyprwm/hypridle.git
cd hypridle


cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install build