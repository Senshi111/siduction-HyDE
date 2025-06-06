#!/bin/bash

# Function to add a value to a configuration file if not present
# Update the package list
echo "Updating package list..."
sudo apt update

# Install necessary dependencies
echo "Installing required dependencies..."
sudo apt install -y \
libavcodec-dev \
libavformat-dev \
libavutil-dev \
libcairo2-dev \
libdeflate-dev \
libdisplay-info-dev \
libdrm-dev \
libegl1-mesa-dev \
libgbm-dev \
libgdk-pixbuf-2.0-dev \
libgdk-pixbuf2.0-bin \
libgirepository1.0-dev \
libgl1-mesa-dev \
libgraphene-1.0-0 \
libgraphene-1.0-dev \
libgulkan-0.15-0t64 \
libgulkan-dev \
libinih-dev \
libinput-dev \
libjbig-dev \
libjpeg-dev \
libjpeg62-turbo-dev \
liblerc-dev \
libliftoff-dev \
liblz4-dev \
liblzma-dev \
libpam0g-dev \
libpango1.0-dev \
libpipewire-0.3-dev \
libseat-dev \
libspa-0.2-dev \
libswresample-dev \
libsystemd-dev \
librsvg2-dev \
libtiff-dev \
libtomlplusplus-dev \
libpugixml-dev \
libudev-dev \
libvkfft-dev \
libvulkan-dev \
libvulkan-volk-dev \
libwayland-dev \
libwebp-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev \
libxkbregistry-dev \
libxcb-composite0-dev \
libxcb-dri3-dev \
libxcb-ewmh-dev \
libxcb-icccm4-dev \
libxcb-present-dev \
libxcb-render-util0-dev \
libxcb-res0-dev \
libxcb-xinput-dev \
libxcb-xkb-dev \
libxml2-dev \
libxxhash-dev \
libzip-dev \
libxcursor-dev \
libxcb-xfixes0-dev \
libxcb-errors-dev \
libre2-dev \
libnotify-dev




add_to_file() {
    local config_file="$1"
    local value="$2"
    
    if ! sudo grep -q "$value" "$config_file"; then
        echo "Adding $value to $config_file"
        sudo sh -c "echo '$value' >> '$config_file'"
    else
        echo "$value is already present in $config_file."
    fi
}

add_to_grub() {
    local value="$1"
    
    # Check if the value is already present in GRUB_CMDLINE_LINUX_DEFAULT
    if ! sudo grep -q "GRUB_CMDLINE_LINUX_DEFAULT=.*$value" /etc/default/grub; then
        echo "Adding $value to GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub"
        
        # Use sed to add the value to the GRUB_CMDLINE_LINUX_DEFAULT line
        sudo sed -i "s/\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"/\1 $value\"/" /etc/default/grub
        sudo update-grub
    else
        echo "$value is already present in GRUB_CMDLINE_LINUX_DEFAULT."
    fi
}

# Clone and build Hyprland
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland || exit

# Check if an NVIDIA GPU is present
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    # Add nvidia_drm.modeset=1 to GRUB_CMDLINE_LINUX_DEFAULT if not present
    add_value="nvidia_drm.modeset=1"
    add_to_grub "$add_value"

    # Define the configuration file and the line to add
    config_file="/etc/modprobe.d/nvidia.conf"
    line_to_add="options nvidia-drm modeset=1"

    # Check if the config file exists
    if [ ! -e "$config_file" ]; then
        echo "Creating $config_file"
        sudo touch "$config_file"
    fi

    add_to_file "$config_file" "$line_to_add"

    # Add NVIDIA modules to initramfs configuration
    modules_to_add="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    modules_file="/etc/initramfs-tools/modules"
    
    if [ -e "$modules_file" ]; then
        add_to_file "$modules_file" "$modules_to_add"
        sudo update-initramfs -u
    else
        echo "Modules file ($modules_file) not found."
    fi
fi

# Build Hyprland using Meson and Ninja
make all && sudo make install

# Return to the previous directory
cd ..
