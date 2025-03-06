#!/bin/bash

# Ensure the script is run as root or with sudo
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root or with sudo."
   exit 1
fi

# Update package list
echo "Updating package list..."
apt update -y || { echo "Failed to update package list. Exiting."; exit 1; }

# List of packages to install
packages=(
    ark
    blueman
    bluez
    brightnessctl
    build-essential
    cliphist
    cmake
    cmake-extras
    curl
    dolphin
    dolphin-plugins
    dunst
    eza
    fastfetch
    ffmpegthumbs
    gawk
    gettext
    gir1.2-graphene-1.0
    git
    glslang-tools
    golang
    grim
    gobject-introspection
    hwdata-dev
    imagemagick
    jq
    kitty
    kio-extras
    kde-cli-tools
    libavcodec-dev
    libavformat-dev
    libavutil-dev
    libcairo2-dev
    libdeflate-dev
    libdisplay-info-dev
    libdrm-dev
    libegl1-mesa-dev
    libgbm-dev
    libgdk-pixbuf-2.0-dev
    libgdk-pixbuf2.0-bin
    libgirepository1.0-dev
    libgl1-mesa-dev
    libgraphene-1.0-0
    libgraphene-1.0-dev
    libgulkan-0.15-0t64
    libgulkan-dev
    libinih-dev
    libinput-dev
    libjbig-dev
    libjpeg-dev
    libjpeg62-turbo-dev
    liblerc-dev
    libliftoff-dev
    liblz4-dev
    liblzma-dev
    libpam0g-dev
    libpango1.0-dev
    libpipewire-0.3-dev
    libseat-dev
    libspa-0.2-dev
    libstartup-notification0
    libswresample-dev
    libsystemd-dev
    librsvg2-dev
    libtiff-dev
    libtiffxx6
    libtomlplusplus-dev
    libpugixml-dev
    libudev-dev
    libvkfft-dev
    libvulkan-dev
    libvulkan-volk-dev
    libwayland-dev
    libwebp-dev
    libxkbcommon-dev
    libxkbcommon-x11-dev
    libxkbregistry-dev
    libxcb-composite0-dev
    libxcb-dri3-dev
    libxcb-ewmh-dev
    libxcb-icccm4-dev
    libxcb-present-dev
    libxcb-render-util0-dev
    libxcb-res0-dev
    libxcb-xinput-dev
    libxcb-xkb-dev
    libxml2-dev
    libxxhash-dev
    libnotify-bin
    libzip-dev
    libxcursor-dev
    libxcb-xfixes0-dev
    libxcb-errors-dev
    lsd
    meson
    notify-osd
    neofetch
    network-manager
    network-manager-gnome
    ninja-build
    nwg-look
    parallel
    pkg-config
    pamixer
    pavucontrol
    pipewire
    pipewire-alsa
    pipewire-audio
    pipewire-jack
    pipewire-pulse
    polkit-kde-agent-1
    pipx
    psmisc
    python3-mako
    python3-markdown
    python3-markupsafe
    python3-yaml
    qt5ct
    qt5-style-kvantum
    qt6-base-dev
    qt6-image-formats-plugins
    qt6-wayland
    qt6ct
    rofi-wayland
    scdoc
    seatd
    slurp
    spirv-tools
    swappy
    swaybar
    swayidle
    udiskie
    vim
    vlukan-utility-libraries-dev
    vlukan-validationlayers
    waybar
    wayland-protocols
    wlogout
    wl-clipboard
    wireplumber
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    xwayland
    zsh
)

# Remove duplicates
unique_packages=($(echo "${packages[@]}" | tr ' ' '\n' | sort -u))

# Install packages
echo "Installing packages..."
for pkg in "${unique_packages[@]}"; do
    if ! apt install -y "$pkg"; then
        echo -e "\033[0;31m[error]\033[0m Failed to install $pkg. Skipping..."
    else
        echo -e "\033[0;32m[success]\033[0m Successfully installed $pkg."
    fi
done

# Optional packages (commented out in the list)
optional_packages=(
    hyprland
    swaylock-effects
)

echo "Attempting to install optional packages (if available)..."
for pkg in "${optional_packages[@]}"; do
    if apt-cache show "$pkg" &>/dev/null; then
        echo "Installing optional package: $pkg"
        apt install -y "$pkg"
    else
        echo "Optional package $pkg is not available in the repositories."
    fi
done

echo "Installation complete!"
