#!/bin/bash

sudo apt install qml


# Clone the hyprlock repository
echo "Cloning hyprlock repository..."
git clone https://github.com/hyprwm/hyprland-qt-support.git
cd hyprland-qt-support


cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DINSTALL_QML_PREFIX=/lib/qt6/qml -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`

sudo cmake --install build