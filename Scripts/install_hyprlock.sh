#!/bin/bash

sudo apt install libpam0g-dev libgbm-dev libdrm-dev libmagic-dev libhyprlang-dev libhyprutils-dev


# Clone the hyprlock repository
echo "Cloning hyprlock repository..."
git clone https://github.com/hyprwm/hyprlock.git
cd hyprlock


cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

sudo cmake --install build