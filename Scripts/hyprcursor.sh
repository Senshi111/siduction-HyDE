#!/bin/bash

sudo apt install libpam0g-dev libgbm-dev libdrm-dev libmagic-dev libhyprlang-dev libhyprutils-dev



git clone https://github.com/hyprwm/hyprcursor.git

cd hyprcursor


cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`


sudo cmake --install build